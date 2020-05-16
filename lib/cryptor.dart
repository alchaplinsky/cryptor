library cryptor;

import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:steel_crypt/steel_crypt.dart';
import './pbkdf2.dart';

class Cryptor {
  static const SALT_LENGTH = 64;
  static const IV_LENGTH = 16;
  static const TAG_LENGTH = 16;
  static const KEY_LENGTH = 32;
  static const KEY_ITERATIONS_COUNT = 100000;

  /// Encrypts passed [cleartext] with key generated based on [password] argument
  String encrypt(String cleartext, String password) {
    Uint8List salt = _generateSalt();
    Uint8List iv = _generateIV();
    String key = _pbkdf2(password, salt);
    String ciphertext =
        AesCrypt(key, 'gcm').encrypt(cleartext, base64.encode(iv));
    return base64.encode(Uint8List.fromList(
        _combineInputs(salt, iv, _generateTag(), ciphertext)));
  }

  /// Encrypts passed [cryptedtext] with key generated based on [password] argument
  String decrypt(String cryptedtext, String password) {
    Uint8List bytes = base64.decode(cryptedtext);
    Uint8List salt = bytes.sublist(0, SALT_LENGTH);
    Uint8List iv = bytes.sublist(SALT_LENGTH, SALT_LENGTH + IV_LENGTH);
    String ciphertext = base64.encode(
        bytes.sublist(SALT_LENGTH + IV_LENGTH + TAG_LENGTH, bytes.length));
    String key = _pbkdf2(password, salt);
    return AesCrypt(key, 'gcm').decrypt(ciphertext, base64.encode(iv));
  }

  List<int> _combineInputs(
      Uint8List salt, Uint8List iv, Uint8List tag, String ciphertext) {
    return salt + iv + tag + base64.decode(ciphertext);
  }

  /// Password Based Key Deriviation function
  String _pbkdf2(String password, Uint8List salt) {
    PBKDF2 generator = new PBKDF2(sha512);
    Uint8List bytes = Uint8List.fromList(generator.generateKey(
        password, base64.encode(salt), KEY_ITERATIONS_COUNT, KEY_LENGTH));
    return String.fromCharCodes(bytes);
  }

  /// Generates empty tag since actual tag can not be obtained from AesCrypt
  Uint8List _generateTag() {
    return new Uint8List(TAG_LENGTH);
  }

  /// Generates salt of given length and returns base64 encoded result
  Uint8List _generateSalt() {
    return _randomBytes(SALT_LENGTH);
  }

  /// Generates initialization vector of given length and returns base64 encoded result
  Uint8List _generateIV() {
    return _randomBytes(IV_LENGTH);
  }

  /// Generates a random byte sequence of given [length]
  List<int> _randomBytes(int length) {
    Uint8List buffer = new Uint8List(length);
    Random range = new Random.secure();
    for (int i = 0; i < length; i++) {
      buffer[i] = range.nextInt(256);
    }
    return buffer;
  }
}
