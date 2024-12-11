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
    apiKey: 'AIzaSyCkCMJWUFG0Kw8EYhXZJJqNJYTb90C2EHI',
    appId: '1:895584626282:web:58665890bfd3f72f22cc13',
    messagingSenderId: '895584626282',
    projectId: 'track-tide',
    authDomain: 'track-tide.firebaseapp.com',
    storageBucket: 'track-tide.appspot.com',
    measurementId: 'G-V86N4E7L8R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIxXloyVQLWb7XxJAgVIvO2X_bfwJbtuM',
    appId: '1:895584626282:android:61b0196a65964de822cc13',
    messagingSenderId: '895584626282',
    projectId: 'track-tide',
    storageBucket: 'track-tide.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXkRqL4I2BJiZAf6k5Fap2UUzBCCKZXQc',
    appId: '1:895584626282:ios:496707da069f156b22cc13',
    messagingSenderId: '895584626282',
    projectId: 'track-tide',
    storageBucket: 'track-tide.appspot.com',
    iosBundleId: 'com.ipop.tracktide',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXkRqL4I2BJiZAf6k5Fap2UUzBCCKZXQc',
    appId: '1:895584626282:ios:e5379e5b76825c4222cc13',
    messagingSenderId: '895584626282',
    projectId: 'track-tide',
    storageBucket: 'track-tide.appspot.com',
    iosBundleId: 'com.example.ipopTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkCMJWUFG0Kw8EYhXZJJqNJYTb90C2EHI',
    appId: '1:895584626282:web:80c2484dc6721aa222cc13',
    messagingSenderId: '895584626282',
    projectId: 'track-tide',
    authDomain: 'track-tide.firebaseapp.com',
    storageBucket: 'track-tide.appspot.com',
    measurementId: 'G-SZKYKMD77J',
  );
}
