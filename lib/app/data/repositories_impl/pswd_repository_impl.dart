import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  Future<String?> decryptPswd() {
    // TODO: implement decryptPswd
    throw UnimplementedError();
  }

  @override
  Future<bool> encryptPswd(String password) {
    // TODO: implement encryptPswd
    throw UnimplementedError();
  }

  @override
  Future<bool> saveMasterKey(String masterKey) async {
    try {
      await secureStorage.write(key: 'masterKey', value: masterKey);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
