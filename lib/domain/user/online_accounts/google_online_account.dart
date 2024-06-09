part of '../user.dart';

class _GoogleOnlineAccountFactory implements OnlineAccountFactory {
  GoogleSignIn? _googleSignIn;
  @override
  Future<OnlineAccount?> createSignInAccount() async {
    try {
      _googleSignIn ??= GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/drive.file',
        ],
      );
      await _googleSignIn!.signOut();
      final account = await _googleSignIn!.signIn();
      if (account != null) return GoogleOnlineAccount(account);
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return null;
  }

  @override
  OnlineAccount? fetchCurrentUserAccount() {
    _googleSignIn ??= GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/drive.file',
      ],
    );
    final account = _googleSignIn!.currentUser;
    if (account != null) return GoogleOnlineAccount(account);
    return null;
  }
}

class GoogleOnlineAccount implements OnlineAccount {
  GoogleOnlineAccount(this.account);

  final GoogleSignInAccount account;

  @override
  Future<void> logout() => GoogleSignIn().signOut();
}
