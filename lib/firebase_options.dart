// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCjEHod_mjick5Wr5ZW4CncbsFRS8_FuzI',
    appId: '1:901714219814:web:ec019c42dee58d556427e7',
    messagingSenderId: '901714219814',
    projectId: 'swarden-809a5',
    authDomain: 'swarden-809a5.firebaseapp.com',
    storageBucket: 'swarden-809a5.appspot.com',
    measurementId: 'G-6D06GBND1Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4e0VHTJVg5qNzk9g--kQQqUD5xgDA2zc',
    appId: '1:901714219814:android:6afc2d7db9ee33806427e7',
    messagingSenderId: '901714219814',
    projectId: 'swarden-809a5',
    storageBucket: 'swarden-809a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoYy5mVWKpA-b9mYH8D3h5sMGTeucmtTc',
    appId: '1:901714219814:ios:11bba423d37614516427e7',
    messagingSenderId: '901714219814',
    projectId: 'swarden-809a5',
    storageBucket: 'swarden-809a5.appspot.com',
    iosBundleId: 'com.example.swarden',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBoYy5mVWKpA-b9mYH8D3h5sMGTeucmtTc',
    appId: '1:901714219814:ios:11bba423d37614516427e7',
    messagingSenderId: '901714219814',
    projectId: 'swarden-809a5',
    storageBucket: 'swarden-809a5.appspot.com',
    iosBundleId: 'com.example.swarden',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCjEHod_mjick5Wr5ZW4CncbsFRS8_FuzI',
    appId: '1:901714219814:web:aad6d1a46ee193676427e7',
    messagingSenderId: '901714219814',
    projectId: 'swarden-809a5',
    authDomain: 'swarden-809a5.firebaseapp.com',
    storageBucket: 'swarden-809a5.appspot.com',
    measurementId: 'G-H7J36DQS4N',
  );
}