library cryptor;

import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:password_hash/password_hash.dart';
import 'package:steel_crypt/steel_crypt.dart';

class Cryptor {
  static const SALT_LENGTH = 64;
  static const IV_LENGTH = 16;
  static const TAG_LENGTH = 16;
  static const KEY_LENGTH = 32;
  static const KEY_ITERATIONS_COUNT = 100000;

  /// Encrypts passed [cleartext] with key generated based on [password] argument
  String encrypt(String cleartext, String password) {
    var salt = _generateSalt();
    var iv = _generateIV();
    var key = _pbkdf2(password, salt);
    var cipher = AesCrypt(key, 'gcm');
    String ciphertext = cipher.encrypt(cleartext, base64.encode(iv));
    return base64.encode(Uint8List.fromList(
        _combineInputs(salt, iv, _generateTag(), ciphertext)));
  }

  /// Encrypts passed [cryptedtext] with key generated based on [password] argument
  String decrypt(String cryptedtext, String password) {
    var bytes = base64.decode(cryptedtext);
    var salt = bytes.sublist(0, SALT_LENGTH);
    var iv = bytes.sublist(SALT_LENGTH, SALT_LENGTH + IV_LENGTH);
    var ciphertext = base64.encode(
        bytes.sublist(SALT_LENGTH + IV_LENGTH + TAG_LENGTH, bytes.length));
    var key = _pbkdf2(password, salt);
    var cipher = AesCrypt(key, 'gcm');
    return cipher.decrypt(ciphertext, base64.encode(iv));
  }

  List<int> _combineInputs(salt, iv, tag, ciphertext) {
    return salt + iv + tag + base64.decode(ciphertext);
  }

  /// Password Based Key Deriviation function
  String _pbkdf2(String password, Uint8List salt) {
    var generator = new PBKDF2(hashAlgorithm: sha512);
    Uint8List bytes = Uint8List.fromList(generator.generateKey(
        password, base64.encode(salt), KEY_ITERATIONS_COUNT, KEY_LENGTH));
    String hash = String.fromCharCodes(bytes);
    return hash;
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
    var buffer = new Uint8List(length);
    final range = new Random.secure();
    for (var i = 0; i < length; i++) {
      buffer[i] = range.nextInt(256);
    }
    return buffer;
  }
}
