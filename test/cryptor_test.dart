import 'package:flutter_test/flutter_test.dart';

import 'package:cryptor/cryptor.dart';

void main() {
  test('Encrypts and decrypts string', () {
    final password = 'password';
    String encrypted = Cryptor.encrypt('data', password);
    expect(Cryptor.decrypt(encrypted, password), 'data');
  });
}
