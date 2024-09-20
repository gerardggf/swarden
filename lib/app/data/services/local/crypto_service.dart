import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart';

final cryptoServiceProvider = Provider<CryptoService>(
  (ref) => CryptoService(),
);

class CryptoService {
  String encryptPassword(String plainTextPassword, String masterKey) {
    final key = Key.fromUtf8(masterKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainTextPassword, iv: iv);
    return encrypted.base64;
  }

  String decryptPassword(String encryptedPassword, String masterKey) {
    final key = Key.fromUtf8(masterKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
    return decrypted;
  }
}
