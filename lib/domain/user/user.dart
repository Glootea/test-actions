import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'user.freezed.dart';
part 'online_accounts/google_online_account.dart';

@freezed
class User with _$User {
  const factory User._private({
    required String name,
    required int id,
    required bool isAdmin,
    @Default([]) List<OnlineAccount> onlineAccounts,
  }) = _User;

  const User._();

  ///Used to sign in user to online account first to pull data from there
  factory User.temp() => const User._private(
        name: 'temp',
        id: 0,
        isAdmin: false,
      );

  static Future<User> fetchOnlineAccounts({
    required String name,
    required int id,
    required bool isAdmin,
  }) async {
    final onlineAccounts = await Future.wait([_GoogleOnlineAccountFactory().fetchCurrentUserAccount()]);
    final actualAccounts = onlineAccounts.where((el) => el != null).map((el) => el!).toList();
    return User._private(name: name, id: id, isAdmin: isAdmin, onlineAccounts: actualAccounts);
  }

  static OnlineAccountFactory getFactory<T extends OnlineAccount>() => switch (T) {
        GoogleOnlineAccount => _GoogleOnlineAccountFactory(),
        _ => throw UnimplementedError('Unknown sign in method: $T'),
      };

  Future<User> logoutAllOnlineAccounts() async {
    await Future.wait(onlineAccounts.map((el) async => el.logout()).toList());
    return copyWith(onlineAccounts: []);
  }

  Future<User> signInSingle<T extends OnlineAccount>() async {
    final factory = getFactory<T>();
    final account = await factory.createSignInAccount();
    if (account == null) return this;
    return copyWith(onlineAccounts: [...onlineAccounts, account]);
  }

  Future<User> logoutSingle<T extends OnlineAccount>() async {
    await onlineAccounts.whereType<T>().firstOrNull?.logout();
    return copyWith(onlineAccounts: onlineAccounts.where((el) => el.runtimeType != T).toList());
  }

  ///Possible sign in options: [GoogleOnlineAccount]
  T? getOnlineAccount<T extends OnlineAccount>() => onlineAccounts.whereType<T>().firstOrNull;
}

sealed class OnlineAccount {
  const OnlineAccount();
  Future<void> logout();
}

abstract interface class OnlineAccountFactory {
  Future<OnlineAccount?> createSignInAccount();
  Future<OnlineAccount?> fetchCurrentUserAccount();
}
