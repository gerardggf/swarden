import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nebben/app/domain/enums.dart';
import 'package:nebben/app/domain/repositories/authentication_repository.dart';
import 'package:nebben/app/presentation/views/auth/register/state/register_state.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/models/user_model.dart';

final registerControllerProvider =
    StateNotifierProvider<RegisterController, RegisterState>(
  (ref) => RegisterController(
    RegisterState(),
    ref.watch(authenticationRepositoryProvider),
  ),
);

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController(
    super.state,
    this.authenticationRepository,
  );

  final AuthenticationRepository authenticationRepository;

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  void updateTaxName(String value) {
    state = state.copyWith(taxName: value);
  }

  void updateCif(String value) {
    state = state.copyWith(cif: value);
  }

  void updateAddress(String value) {
    state = state.copyWith(address: value);
  }

  void updateCity(String value) {
    state = state.copyWith(city: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  void updateAcceptsMailing(bool value) {
    state = state.copyWith(acceptsMailing: value);
  }

  void updateAcceptsPolicy(bool value) {
    state = state.copyWith(acceptsPolicy: value);
  }

  Future<Either<FirebaseResult, UserModel>> register(bool isCompany) async {
    updateFetching(true);

    final result = await authenticationRepository.register(
      email: state.email,
      name: state.name,
      lastName: state.lastName,
      address: state.address,
      city: state.city,
      isCompany: isCompany,
      password: state.password,
    );
    updateFetching(false);
    return result;
  }
}
