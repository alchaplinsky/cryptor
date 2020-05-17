import 'package:cryptor/cryptor.dart';

void main() {
  final text = 'SOME DATA TO ENCRYPT';
  final password = 'password';

  final encrypted = Cryptor.encrypt(text, password);
  final decrypted = Cryptor.decrypt(encrypted, password);

  print(encrypted);
  print(decrypted);
}
