import 'package:cryptor/cryptor.dart';

void main() {
  final text = 'SOME DATA TO ENCRYPT';
  final password = 'password';

  final cryptor = Cryptor();

  final encrypted = cryptor.encrypt(text, password);
  final decrypted = cryptor.decrypt(encrypted, password);

  print(encrypted);
  print(decrypted);
}
