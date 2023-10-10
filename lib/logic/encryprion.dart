import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

import 'package:queue/secret.dart';

class Encryption {
  static final _encrypter = Encrypter(Salsa20(Key.fromBase64(ENCRIPTION_KEY)));
  static final _iv = IV.fromLength(8);

  static Uint8List encryct(String data) {
    final output = _encrypter
        .encrypt(
          data,
          iv: _iv,
        )
        .bytes;
    print(decrypt(output));
    return output;
  }

  static String decrypt(Uint8List data) {
    return _encrypter.decrypt(Encrypted(data), iv: _iv);
  }
}
