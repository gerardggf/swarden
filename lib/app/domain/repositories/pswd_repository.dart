import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/data/services/local/crypto_service.dart';

import '../../core/global_providers.dart';
import '../../data/repositories_impl/pswd_repository_impl.dart';

final pswdRepositoryProvider = Provider<PswdRepository>(
  (ref) => PswdRepositoryImpl(
    secureStorage: ref.watch(flutterSecureStorageProvider),
    cryptoService: ref.watch(cryptoServiceProvider),
  ),
);

abstract class PswdRepository {
  Future<String?> encryptMessage(String message);
  Future<String?> decryptMessage(String encryptedMessage);

  //saves master key when user is logged in and it is deleted when the user logs out
  Future<bool> saveMasterKey(String? masterKey);
}
