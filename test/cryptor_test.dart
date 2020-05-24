import 'package:flutter_test/flutter_test.dart';

import 'package:cryptor/cryptor.dart';

void main() {
  test('Encrypts and decrypts string', () {
    final password = 'password';
    String encrypted = Cryptor.encrypt('data', password);
    expect(Cryptor.decrypt(encrypted, password), 'data');
  });

  test('Decrypts data encrypted on other platform', () {
    final encrypted =
        'NhhXJJ+bhoQCSTcTWNW25AtmmVGGfBXEkYdldy/TK3zluwu40LIPmWbpXtw1ntnwx/ZfNJPeGlFlh1s+QawX8NgTNJfBVfW1s8l4DO9w+1kWiYvlLX3klaNSfPEuOHvKMpnyJ+t6p+j3NiBHcAvbKmYCvLkUHGgSh9r0nCQuADnvyvjo3RO0BjegxM/GYze8nQupQQYeeshrF19bOQ4Wmy9mDScWuqY9cRMNDd+BRuWWFi1tpXUGNc5yblHW4qABW4FR1r+Hgt4MwfaYfKO4gc8+tmPnf/zvtXZDeoKaXIOy1+Rn6uN8aNoZSEohn4fsyOpUDhO+KWpiJSCWxipnQeuqoeALG+af/5qgxa0HFcUeg7vxlGB8YgK/3nbproN/3/74EWANziHodS0A/E+OM9X+ltVAeaSk3DfMxzHH178lia6RDrxuh4DElgh6b55uejhKrxrCxTzSkn8TIQkspWse47VdCXSrlQukdh7n2qjKWmc06CbXqzsoN6BHJ4Aw/l0KyiFveimG1jB8PFPPgATf9gNKuQ3YinvYrv141zJB1kpGjeSu7mRc/oYyLofoeLhjwHPF/QR4G5EuhFUjWpPr4NuRJgGBLefdZJGjJkeOMjkFDCQ6GorFlwCc9Lc6OAUVJ/JDOXaoLqexnTrAFHmjxy05mgzY6JzHpP+4xmg+g9wjJXyFEx3EX9HHD2ddmYLjFLroA36SmGZoegzb/UhOKKpEHtC/Yu8EPiwgVhkXIVBRZvVRh5jBS7LQkyI6KmDs7vmvutUq3zt109rxWQ==';
    final password =
        'sQnzu7wkTrgkQZF+0G1hi5AI3Qmzvv0bXgc5THBqi7mAsdd4Xll27ASbRt9fEyavWi6m0QP9B8lThf+rDKy8hg==';
    expect(Cryptor.decrypt(encrypted, password),
        '{"entries":[{"id":"MSz3VJcdQ","type":"login","title":"Facebook","website":"https://facebook.com","username":"alchaplinsky","password":"rUHmTveu8a6IGg4wK2GYcq5jsowzSoSPwQpn9ibT1Kb/VaRbwa5c+UneHmPm0B/whZk0mfRsodxpPkXoiatlmSN7Q5K3b+Wrb1TXkQ5EKk905kcPsIa6DsJyNBGmmX7WavZC76h5W2vjk/SKhaQM/y/ValtecFU8Zs43P0PcM78=","email":"","note":"","otp":"","password_updated_at":"2020-05-23T23:59:24.592+02:00","createdAt":"2020-05-23T23:59:25.575+02:00","updatedAt":"2020-05-23T23:59:52.796+02:00"}]}');
  });

  test('Hashes password', () {
    expect(Cryptor.hash('password'),
        'sQnzu7wkTrgkQZF+0G1hi5AI3Qmzvv0bXgc5THBqi7mAsdd4Xll27ASbRt9fEyavWi6m0QP9B8lThf+rDKy8hg==');
  });
}
