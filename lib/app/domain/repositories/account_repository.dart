import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/data/repositories_impl/account_repository_impl.dart';
import 'package:swarden/app/domain/models/user_model.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';
import 'package:swarden/app/domain/repositories/pswd_repository.dart';
import 'package:swarden/app/domain/swarden_exception/swarden_exception.dart';

import '../models/pswd_item_model.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepositoryImpl(
    authRepository: ref.watch(authenticationRepositoryProvider),
    pswdRepository: ref.watch(pswdRepositoryProvider),
  ),
);

abstract class AccountRepository {
  Future<SwardenEither<List<PswdItemModel>>> getPswdItems();
  Stream<SwardenEither<List<PswdItemModel>>> subscribeToPswdItems();
  Future<bool> addPswdItem(
    PswdItemModel pswditem,
  );
  Future<bool> deletePswdItem(String itemId);
  Future<bool> updatePswdItem(PswdItemModel item);

  //user
  Future<bool> updateUserAccountInfo(UserModel user);
}
