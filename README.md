# cryptor

AES GCM 256 cryptor

## Usage

```dart
var cryptor = new Cryptor();
var cryptedtext = cryptor.encrypt('SOME DATA TO ENCRYPT', 'password');
return cryptor.decrypt(cryptedtext, 'password'); // => 'SOME DATA TO ENCRYPT'
```
