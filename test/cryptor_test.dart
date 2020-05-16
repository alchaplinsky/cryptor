import 'package:flutter_test/flutter_test.dart';

import 'package:cryptor/cryptor.dart';

void main() {
  test('Encrypts and decrypts string', () {
    final password = 'password';
    final cryptor = Cryptor();
    String encrypted = cryptor.encrypt('data', password);
    expect(cryptor.decrypt(encrypted, password), 'data');
  });
}
