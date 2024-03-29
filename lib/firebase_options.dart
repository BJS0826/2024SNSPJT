// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDVzVAU6JSOCqjN7VCRipapggZpXyvVzBU',
    appId: '1:680598587804:web:c4771a0255f0a94fd1e059',
    messagingSenderId: '680598587804',
    projectId: 'sns2024-f3922',
    authDomain: 'sns2024-f3922.firebaseapp.com',
    storageBucket: 'sns2024-f3922.appspot.com',
    measurementId: 'G-X4LP7N0S15',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8HBG-XgVFzG1Wq5kHVAX_a-SrB7YVUQ0',
    appId: '1:680598587804:android:40aab0e3f1472dbfd1e059',
    messagingSenderId: '680598587804',
    projectId: 'sns2024-f3922',
    storageBucket: 'sns2024-f3922.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGPd6_QohTWM0bwbxNaPP_p1vGo3SH0nY',
    appId: '1:680598587804:ios:94ceaeff89d048c0d1e059',
    messagingSenderId: '680598587804',
    projectId: 'sns2024-f3922',
    storageBucket: 'sns2024-f3922.appspot.com',
    iosBundleId: 'com.example.christianSns',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGPd6_QohTWM0bwbxNaPP_p1vGo3SH0nY',
    appId: '1:680598587804:ios:be49412dd74e8c55d1e059',
    messagingSenderId: '680598587804',
    projectId: 'sns2024-f3922',
    storageBucket: 'sns2024-f3922.appspot.com',
    iosBundleId: 'com.example.christianSns.RunnerTests',
  );
}
