import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swarden/app/core/const/global.dart';
import 'package:swarden/app/core/enums/storage_keys.dart';
import 'package:swarden/app/data/services/local/crypto_service.dart';

import '../../domain/repositories/pswd_repository.dart';

class PswdRepositoryImpl implements PswdRepository {
  final FlutterSecureStorage secureStorage;
  final CryptoService cryptoService;

  PswdRepositoryImpl({
    required this.secureStorage,
    required this.cryptoService,
  });

  @override
  Future<bool> saveMasterKey(String? masterKey) async {
    try {
      if (masterKey == null) {
        await secureStorage.delete(key: StorageKeysEnum.masterKey.name);
        return true;
      }
      await secureStorage.write(
        key: StorageKeysEnum.masterKey.name,
        value: masterKey,
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<String?> encryptMessage(String message) async {
    try {
      final masterKey =
          await secureStorage.read(key: StorageKeysEnum.masterKey.name);
      if (masterKey == null) {
        if (kDebugMode) {
          print("Missing masterKey");
        }
        return null;
      }
      return cryptoService.encryptPassword(
        message,
        masterKey,
        Global.messagesKeyword,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  @override
  Future<String?> decryptMessage(String encryptedMessage) async {
    try {
      final masterKey =
          await secureStorage.read(key: StorageKeysEnum.masterKey.name);

      if (masterKey == null) {
        if (kDebugMode) {
          print("Missing masterKey");
        }
        return null;
      }
      return cryptoService.decryptPassword(
        encryptedMessage,
        masterKey,
        Global.messagesKeyword,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
