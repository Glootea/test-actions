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

  factory User.fetchOnlineAccount({
    required String name,
    required int id,
    required bool isAdmin,
  }) {
    final onlineAccounts =
        [_GoogleOnlineAccountFactory().fetchCurrentUserAccount()].whereType<OnlineAccount>().toList();

    return User._private(name: name, id: id, isAdmin: isAdmin, onlineAccounts: onlineAccounts);
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
}

sealed class OnlineAccount {
  const OnlineAccount();
  Future<void> logout();
}

abstract interface class OnlineAccountFactory {
  Future<OnlineAccount?> createSignInAccount();
  OnlineAccount? fetchCurrentUserAccount();
}
