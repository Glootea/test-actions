import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/domain/user/user.dart';

class UserCubit extends Cubit<User?> {
  UserCubit._(this._storage) : super(null);
  final KeyValueStorage _storage;
  bool _inited = false;

  static Future<UserCubit> create(KeyValueStorage storage) async {
    final cubit = UserCubit._(storage);
    await cubit._init();
    return cubit;
  }

  Future<void> _init() async {
    final (userName, rowNumberString, isAdmin) = await (
      _storage.get(StoredValues.userName),
      _storage.get(StoredValues.userRowNumber),
      _storage.get(StoredValues.userIsAdmin),
    ).wait;
    _inited = true;
    if (rowNumberString == null || userName == null) return;
    final rowNumber = int.parse(rowNumberString);
    final user = await User.fetchOnlineAccounts(name: userName, id: rowNumber, isAdmin: isAdmin == 'true');
    emit(user);
    if (kDebugMode) {
      print('User cubit initialized: $state');
    }
  }

  Future<void> login({
    required String name,
    required int rowNumber,
    required bool isAdmin,
  }) async {
    assert(_inited == true, "User cubit hasn't been initialized for login");
    final user = await User.fetchOnlineAccounts(name: name, id: rowNumber, isAdmin: isAdmin);
    emit(user);
    await (
      _storage.set(StoredValues.userName, name),
      _storage.set(StoredValues.userRowNumber, rowNumber.toString()),
      _storage.set(StoredValues.userIsAdmin, isAdmin.toString())
    ).wait;
    log('User cubit state changed: $state');
  }

  Future<void> logout() async {
    assert(_inited == true, "User cubit hasn't been initialized for logout");
    final tempUser = state;
    emit(null);
    await (
      tempUser?.logoutAllOnlineAccounts().then((_) {}) ?? Future.value(),
      _storage.clean(StoredValues.userName),
      _storage.clean(StoredValues.userRowNumber),
      _storage.clean(StoredValues.userIsAdmin),
    ).wait;
  }

  bool get isLoggedIn => state != null;
  String get name => state?.name ?? '';
  bool get isAdmin => state?.isAdmin ?? false;
  int get rowNumber => state?.id ?? 0;

  ///Possible sign in options: [GoogleOnlineAccount]
  Future<void> signInSingle<T extends OnlineAccount>() async {
    assert(_inited == true, "User cubit hasn't been initialized for sign in");
    assert(T == GoogleOnlineAccount, 'Unsupported sign in type: $T');
    final user = state;
    if (user == null) return;
    emit(await user.signInSingle<T>());
  }

  ///Possible log out options: [GoogleOnlineAccount]
  Future<void> logoutSingle<T extends OnlineAccount>() async {
    assert(_inited == true, "User cubit hasn't been initialized for logout");
    final user = state;
    if (user == null) return;
    emit(await user.logoutSingle<T>());
  }
}
