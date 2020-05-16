import 'package:flutter_test/flutter_test.dart';

import 'package:crypto/crypto.dart';
import 'package:cryptor/pbkdf2.dart';

void main() {
  List<int> key;
  final PBKDF2 generator = new PBKDF2(sha512);
  final String password = 'password';
  final String salt =
      'Tp9wWbrlw74m/96i0TgMMWP7ROG1OnOz7OaQjcqeSFcYPYfEkGZWPg2vI+/3dK2cSw1vtyerL+PnEbdc0OrhXA==';

  test('Derives 16 bit key from password and salt', () {
    key = generator.generateKey(password, salt, 1000, 16);
    expect(key, [
      128,
      139,
      203,
      231,
      115,
      221,
      176,
      195,
      86,
      98,
      230,
      182,
      72,
      144,
      134,
      218
    ]);
  });

  test('Derives 32 bit key from password and salt', () {
    key = generator.generateKey(password, salt, 1000, 32);
    expect(key, [
      128,
      139,
      203,
      231,
      115,
      221,
      176,
      195,
      86,
      98,
      230,
      182,
      72,
      144,
      134,
      218,
      68,
      242,
      42,
      106,
      84,
      209,
      189,
      61,
      186,
      108,
      63,
      8,
      194,
      12,
      88,
      125
    ]);
  });

  test('Derives 64 bit key from password and salt', () {
    key = generator.generateKey(password, salt, 1000, 64);
    print(key);
    expect(key, [
      128,
      139,
      203,
      231,
      115,
      221,
      176,
      195,
      86,
      98,
      230,
      182,
      72,
      144,
      134,
      218,
      68,
      242,
      42,
      106,
      84,
      209,
      189,
      61,
      186,
      108,
      63,
      8,
      194,
      12,
      88,
      125,
      209,
      124,
      149,
      178,
      176,
      45,
      202,
      25,
      183,
      201,
      106,
      78,
      131,
      20,
      114,
      133,
      95,
      142,
      57,
      164,
      72,
      234,
      95,
      147,
      242,
      181,
      70,
      239,
      14,
      220,
      3,
      125
    ]);
  });
}
