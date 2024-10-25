import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoServiceProvider = Provider<CryptoService>(
  (ref) => CryptoService(),
);

class CryptoService {
  String encryptPassword(
    String plainTextPassword,
    String masterKey,
    String keyword,
  ) {
    final key = _generateKey(masterKey, keyword);
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(plainTextPassword, iv: iv);
    final encryptedData = base64Encode(iv.bytes + encrypted.bytes);
    return encryptedData;
  }

  String decryptPassword(
    String encryptedPassword,
    String masterKey,
    String keyword,
  ) {
    final key = _generateKey(masterKey, keyword);
    final encryptedBytes = base64Decode(encryptedPassword);
    final iv = IV(encryptedBytes.sublist(0, 16));
    final encryptedData = Encrypted(encryptedBytes.sublist(16));

    final encrypter = Encrypter(
      AES(key, mode: AESMode.cbc, padding: 'PKCS7'),
    );
    final decrypted = encrypter.decrypt(encryptedData, iv: iv);
    return decrypted;
  }

  Key _generateKey(String masterKey, String keyword) {
    final combined = masterKey + keyword;
    final hash = sha256.convert(utf8.encode(combined)).bytes;
    return Key(Uint8List.fromList(hash).sublist(0, 32));
  }
}
