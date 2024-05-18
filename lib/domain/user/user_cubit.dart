import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/domain/user/user.dart';

class UserCubit extends Cubit<User?> {
  final KeyValueStorage _storage;
  UserCubit(this._storage) : super(null) {
    init();
  }

  Future<void> init() async {
    final (userName, rowNumberString, isAdmin) = await (
      _storage.get(StoredValues.userName),
      _storage.get(StoredValues.userRowNumber),
      _storage.get(StoredValues.userIsAdmin)
    ).wait;
    if (rowNumberString == null || userName == null) return;
    final rowNumber = int.parse(rowNumberString);
    emit(User(name: userName, rowNumber: rowNumber, isAdmin: isAdmin == 'true'));
    log("User cubit initialized: $state");
  }

  Future<void> login({
    required String name,
    required int rowNumber,
    required bool isAdmin,
  }) async {
    emit(User(name: name, rowNumber: rowNumber, isAdmin: isAdmin));
    await (
      _storage.set(StoredValues.userName, name),
      _storage.set(StoredValues.userRowNumber, rowNumber.toString()),
      _storage.set(StoredValues.userIsAdmin, isAdmin.toString())
    ).wait;
    log("User cubit state changed: $state");
  }

  Future<void> logout() async {
    emit(null);
    await (
      _storage.clean(StoredValues.userName),
      _storage.clean(StoredValues.userRowNumber),
      _storage.clean(StoredValues.userIsAdmin),
    ).wait;
  }

  bool get isLoggedIn => state != null;

  String get name => state?.name ?? '';
  bool get isAdmin => state?.isAdmin ?? false;
  int get rowNumber => state?.rowNumber ?? 0;
}
