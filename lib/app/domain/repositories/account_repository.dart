import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/data/repositories_impl/account_repository_impl.dart';
import 'package:swarden/app/domain/either/either.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';

import '../models/pswd_item_model.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepositoryImpl(
    authRepository: ref.watch(authenticationRepositoryProvider),
  ),
);

abstract class AccountRepository {
  Future<Either<Exception, List<PswdItemModel>>> getPswdItems();
  Stream<Either<Exception, List<PswdItemModel>>> subscribeToPswdItems();
  Future<bool> addPswdItem({
    required String name,
    required String username,
    required String pswd,
  });
  Future<bool> deletePswdItem(String itemId);
  Future<bool> updatePswdItem(PswdItemModel item);
}
