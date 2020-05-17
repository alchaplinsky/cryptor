# cryptor

AES-GCM-256 algorithm cryptor

## Usage

```dart
  var text = 'SOME DATA TO ENCRYPT';
  var password = 'password';

  var encrypted = Cryptor.encrypt(text, password);
  var decrypted = Cryptor.decrypt(encrypted, password);

  print(encrypted);
  print(decrypted);
```
