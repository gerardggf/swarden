import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final localAuthProvider = Provider<LocalAuthentication>(
  (ref) => LocalAuthentication(),
);

// final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
//   (ref) => const FlutterSecureStorage(),
// );
