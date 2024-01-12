import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class Encryption {
  static const _encriptionKey = String.fromEnvironment(
    'ENCRIPTION_KEY',
    defaultValue: 'bwpIDnE0wAZB3J0qW/nfdd/ENBtfVlGjepmm/NLxEwWZQjOJTFSQ7Ap3GqUQfXlE',
  );
  static final _encrypter = Encrypter(AES(Key.fromBase64(_encriptionKey)));
  static final _iv = IV.fromBase64(_encriptionKey.substring(0, 4));
  static String encryct(String data) {
    final output = _encrypter
        .encrypt(
          data,
          iv: _iv,
        )
        .base64
        .replaceAll('/', '[]');
    return output;
  }

  static String decrypt(String data) {
    return _encrypter.decrypt(Encrypted(Uint8List.fromList(base64.decode(data.replaceAll('[]', '/')))), iv: _iv);
  }
}
