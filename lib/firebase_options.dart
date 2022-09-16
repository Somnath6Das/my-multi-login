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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC0OwkE1gY0q-ZQr5ww2k1n4qavrpGLMs4',
    appId: '1:506211941047:web:f30dd08436b74203f1eb32',
    messagingSenderId: '506211941047',
    projectId: 'my-multiple-login',
    authDomain: 'my-multiple-login.firebaseapp.com',
    storageBucket: 'my-multiple-login.appspot.com',
    measurementId: 'G-WMG6RV3TY4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfBpCoXCmAbajJultB4X7ZBsEQ8vGLLIE',
    appId: '1:506211941047:android:4ceca5d80c3c2b12f1eb32',
    messagingSenderId: '506211941047',
    projectId: 'my-multiple-login',
    storageBucket: 'my-multiple-login.appspot.com',
  );
}