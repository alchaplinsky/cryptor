import 'dart:convert';
import 'dart:typed_data';

import 'package:steel_crypt/PointyCastleN/export.dart';

class AesGcm {
  String _key32;

  AesGcm(this._key32);

  String encrypt(String input, [String iv = '']) {
    Uint8List key = Uint8List.fromList(_key32.codeUnits);
    Uint8List ivLocal = Uint8List.fromList(iv.codeUnits);
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV<KeyParameter>(KeyParameter(key), ivLocal), null);
    PaddedBlockCipher cipher = PaddedBlockCipher('AES/GCM/PKCS7');
    cipher..init(true, params);
    Uint8List inter = cipher.process(utf8.encode(input) as Uint8List);
    return base64.encode(inter);
  }

  String decrypt(String encrypted, [String iv = '']) {
    Uint8List key = Uint8List.fromList(_key32.codeUnits);
    Uint8List ivLocal = Uint8List.fromList(iv.codeUnits);
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(key), ivLocal), null);
    PaddedBlockCipher cipher = PaddedBlockCipher('AES/GCM/PKCS7');
    cipher..init(false, params);
    Uint8List inter = cipher.process(base64.decode(encrypted));
    return utf8.decode(inter);
  }
}
