import 'dart:core';
import 'package:googleapis/sheets/v4.dart';
import 'package:http/http.dart' hide Request;

class GoogleSheetsApiWrapper {
  GoogleSheetsApiWrapper(Client client) : sheetsApi = SheetsApi(client);

  final SheetsApi sheetsApi;
  SpreadSheetProcessor spreadSheet(String fileID) => SpreadSheetProcessor(sheetsApi, fileID);

  SheetProcessor sheet(String fileID, SheetsList sheet) => SheetProcessor(sheetsApi, fileID, sheet);
}

class SpreadSheetProcessor {
  SpreadSheetProcessor(this._api, this._fileID);
  final String _fileID;
  final SheetsApi _api;
}

enum SheetsList {
  info('Info', 1),
  names('Names', 2),
  lessons('Lessons', 3),
  lessonTimes('Lesson Times', 4);

  const SheetsList(this.name, this.id);

  final String name;
  final int id;
}

class SheetProcessor {
  SheetProcessor(this._api, this._fileID, this._sheetID);
  final String _fileID;
  final SheetsList _sheetID;
  final SheetsApi _api;

  Future<BatchUpdateSpreadsheetResponse> writeColumn(List<String> values, {required int column, int? startRow}) async {
    final requests = List.generate(
      values.length,
      (index) => _requestToWriteField(_sheetID.id, index + (startRow ?? 0), column, values[index]),
    );
    return _makeRequest(requests);
  }

  Future<BatchUpdateSpreadsheetResponse> writeRow(List<String> values, {required int row, int? startColumn}) async {
    final requests = List.generate(
      values.length,
      (index) => _requestToWriteField(_sheetID.id, row, index + (startColumn ?? 0), values[index]),
    );
    return _makeRequest(requests);
  }

  Future<BatchUpdateSpreadsheetResponse> _makeRequest(List<Request> requests) {
    final batchRequest = BatchUpdateSpreadsheetRequest(requests: requests);
    return _api.spreadsheets.batchUpdate(batchRequest, _fileID);
  }

  Request _requestToWriteField(int sheetId, int row, int column, String value) => Request(
        updateCells: UpdateCellsRequest(
          fields: '*',
          range: GridRange(startRowIndex: row, startColumnIndex: column, sheetId: sheetId),
          rows: [
            RowData(
              values: [CellData(userEnteredValue: ExtendedValue(stringValue: value))],
            ),
          ],
        ),
      );
  Future<List<String>?> readRow({required int row, int startColumn = 0, int? endColumn}) async {
    final tableRow = row + 1;
    return _readRange('${_sheetID.name}!$tableRow:$tableRow').then((row) => row?.sublist(startColumn, endColumn));
  }

  Future<List<String>?> readColumn({required int column, int startRow = 0, int? endRow}) async {
    final letter = numToLetter(column);
    return _readRange('${_sheetID.name}!$letter:$letter').then((row) => row?.sublist(startRow, endRow));
  }

  Future<List<String>?> _readRange(String range) async {
    final spreadSheet = await _api.spreadsheets.get(_fileID, ranges: [range], $fields: 'sheets');
    final sheet = spreadSheet.sheets?.where((s) => s.properties?.sheetId == _sheetID.id).first;
    final data = sheet?.data;
    if (sheet == null || data == null) return null;
    final result = data
        .map(
          (grid) => grid.rowData?.map(_parseRowData).expand((rows) => rows ?? Iterable<String>.generate(1, (_) => '')),
        )
        .expand((row) => row ?? Iterable<String>.generate(1, (_) => ''))
        .toList();

    return result;
  }

  List<String>? _parseRowData(RowData row) {
    final parsedRow = row.values?.map((cellData) => cellData.formattedValue ?? '');
    if (parsedRow?.isEmpty ?? false) return null;
    return parsedRow?.toList();
  }

  ///Converts column number to its letter equivalent
  String numToLetter(int num) => String.fromCharCode(num + 'A'.codeUnitAt(0));
}
