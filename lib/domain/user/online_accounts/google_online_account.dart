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
      if (account != null) return GoogleOnlineAccount(_googleSignIn!, account);
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return null;
  }

  @override
  Future<OnlineAccount?> fetchCurrentUserAccount() {
    _googleSignIn ??= GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/drive.file',
      ],
    );
    return _googleSignIn!.signInSilently().then((value) {
      print('Account: $value');
      if (value != null) return GoogleOnlineAccount(_googleSignIn!, value);
      return null;
    });
  }
}

class GoogleOnlineAccount implements OnlineAccount {
  GoogleOnlineAccount(this.googleSignIn, this.account);

  final GoogleSignIn googleSignIn;
  final GoogleSignInAccount account;

  @override
  Future<void> logout() => GoogleSignIn().signOut();
}
