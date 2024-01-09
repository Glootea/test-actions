import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class Encryption {
  static const ENCRIPTION_KEY = ''; //TODO: get ENCRIPTION_KEY from env
  static final _encrypter = Encrypter(AES(Key.fromBase64(ENCRIPTION_KEY))); // TODO: get key
  static final _iv = IV.fromBase64(ENCRIPTION_KEY.substring(0, 4));

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

  static String _decrypt(String data) {
    return _encrypter.decrypt(Encrypted(Uint8List.fromList(base64.decode(data))), iv: _iv);
  }

  static String decrypt(String data) {
    return _encrypter.decrypt(Encrypted(Uint8List.fromList(base64.decode(data.replaceAll('[]', '/')))), iv: _iv);
  }
}