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
    apiKey: 'AIzaSyAvD_AQEuCV90w61alRg7zmdhLU_m4z60U',
    appId: '1:1066692871583:web:d1c80ccb00d6f10f6329aa',
    messagingSenderId: '1066692871583',
    projectId: 'devblog-8aad2',
    authDomain: 'devblog-8aad2.firebaseapp.com',
    storageBucket: 'devblog-8aad2.appspot.com',
    measurementId: 'G-CNHCK00RHV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEBHNoMBnoxGugyTggS-3XxvEgYDi0mIU',
    appId: '1:1066692871583:android:29d59564f87649b16329aa',
    messagingSenderId: '1066692871583',
    projectId: 'devblog-8aad2',
    storageBucket: 'devblog-8aad2.appspot.com',
  );
}