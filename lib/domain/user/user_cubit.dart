import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/domain/user/user.dart';

class UserCubit extends Cubit<User?> {
  final KeyValueStorage _storage;
  bool _inited = false;
  UserCubit(this._storage) : super(null);

  Future<void> init() async {
    final (userName, rowNumberString, isAdmin) = await (
      _storage.get(StoredValues.userName),
      _storage.get(StoredValues.userRowNumber),
      _storage.get(StoredValues.userIsAdmin)
    ).wait;
    if (rowNumberString == null || userName == null) return;
    final rowNumber = int.parse(rowNumberString);
    emit(User(name: userName, id: rowNumber, isAdmin: isAdmin == 'true'));
    log("User cubit initialized: $state");
    _inited = true;
  }

  Future<void> login({
    required String name,
    required int rowNumber,
    required bool isAdmin,
  }) async {
    assert(_inited == true, "User cubit hasn't been initialized");
    emit(User(name: name, id: rowNumber, isAdmin: isAdmin));
    await (
      _storage.set(StoredValues.userName, name),
      _storage.set(StoredValues.userRowNumber, rowNumber.toString()),
      _storage.set(StoredValues.userIsAdmin, isAdmin.toString())
    ).wait;
    log("User cubit state changed: $state");
  }

  Future<void> logout() async {
    assert(_inited == true, "User cubit hasn't been initialized");
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
  int get rowNumber => state?.id ?? 0;
}
