import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:queue/data/online_database_strings.dart';

class GoogleDriveProvider {
  GoogleDriveProvider._(this._googleSignIn);

  final GoogleSignIn _googleSignIn;
  bool _inited = false;

  static Future<GoogleDriveProvider> create(GoogleSignIn googleSignIn) async {
    final googleDriveProvider = GoogleDriveProvider._(googleSignIn);
    await googleDriveProvider._init();
    return googleDriveProvider;
  }

  Future<void> _init() async {
    if (_inited) return;
    try {
      _httpClient = (await _googleSignIn.authenticatedClient())!;
      _driveApi = DriveApi(_httpClient);
      _folder = await _driveApi.files.list(q: "name = '${OnlineDatabaseStrings.folderName}'").then((value) async {
        final folder = value.files?.firstOrNull;
        if (folder == null) {
          if (kDebugMode) print('Creating queueminder folder');
          return _driveApi.files
              .create(File(mimeType: FileType.folder.mimeType, name: OnlineDatabaseStrings.folderName));
        }
        if (kDebugMode) print('Queueminder folder exists');
        return folder;
      });

      _inited = true;
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  late AuthClient _httpClient;
  late DriveApi _driveApi;
  late File _folder;

  Future<bool> fileExists(String name) async {
    assert(_inited, "GoogleDriveProvider hasn't been initialized");

    return _driveApi.files
        .list(q: "name = '$name' and parents = '${_folder.id}'")
        .then((v) => v.files?.firstOrNull != null);
  }

  ///Creates file with [name] and returns its ID, throws [ApiRequestError] if api failed
  Future<String> createFile({required String name, required FileType type}) async {
    assert(_inited, "GoogleDriveProvider hasn't been initialized");

    final file = File(mimeType: type.mimeType, name: name, parents: [_folder.id!]);
    final id = await _driveApi.files.create(file).then((v) => v.id!);
    final permisson =
        Permission(role: 'writer', type: 'user', emailAddress: 'queue-410@queue-401413.iam.gserviceaccount.com');
    await _driveApi.permissions.create(permisson, id);
    return id;
  }

  Future<void> deleteFile(String name) async {
    assert(_inited, "GoogleDriveProvider hasn't been initialized");
    final fileID = await _driveApi.files
        .list(q: "name = '$name' and parents = '${_folder.id}'")
        .then((v) => v.files?.firstOrNull?.id);
    if (fileID == null) {
      if (kDebugMode) print('File $name not found');
      return;
    }
    if (kDebugMode) print('Deleting file $fileID');
    await _driveApi.files.delete(fileID);
  }
}

enum FileType {
  folder('application/vnd.google-apps.folder'),
  spreadsheet('application/vnd.google-apps.spreadsheet');

  const FileType(this.mimeType);
  final String mimeType;
}
