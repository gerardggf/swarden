import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:swarden/app/core/global_providers.dart';

final biometricsServiceProvider = Provider<BiometricsService>(
  (ref) => BiometricsService(
    localAuth: ref.watch(localAuthProvider),
  ),
);

class BiometricsService {
  final LocalAuthentication localAuth;

  BiometricsService({required this.localAuth});

  Future<bool> canCheckBiometrics() async {
    final canCheckBiometrics = await localAuth.canCheckBiometrics;
    return canCheckBiometrics && await localAuth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      return await localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(
          e.toString(),
        );
      }
      return false;
    }
  }
}
