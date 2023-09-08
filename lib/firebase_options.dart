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
    apiKey: 'AIzaSyDsnF5lLK88_92_aaMUg7xh3deoPf3GRyE',
    appId: '1:76643925457:web:1e7bddc086e91561d6f4f0',
    messagingSenderId: '76643925457',
    projectId: 'interview-questio',
    authDomain: 'interview-questio.firebaseapp.com',
    storageBucket: 'interview-questio.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3x8pN3EvXg0-z2BHfZpwHlGrk8Snf2s4',
    appId: '1:76643925457:android:526e2447095fa66ed6f4f0',
    messagingSenderId: '76643925457',
    projectId: 'interview-questio',
    storageBucket: 'interview-questio.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDx8kOq0BpazSRMC7xSNo3sy6us6InUctk',
    appId: '1:76643925457:ios:e3fee3674571cc35d6f4f0',
    messagingSenderId: '76643925457',
    projectId: 'interview-questio',
    storageBucket: 'interview-questio.appspot.com',
    iosClientId: '76643925457-5vfh8kpdqbffkudsn0j02o6sara0c2sq.apps.googleusercontent.com',
    iosBundleId: 'com.example.interviewPrep',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDx8kOq0BpazSRMC7xSNo3sy6us6InUctk',
    appId: '1:76643925457:ios:e3fee3674571cc35d6f4f0',
    messagingSenderId: '76643925457',
    projectId: 'interview-questio',
    storageBucket: 'interview-questio.appspot.com',
    iosClientId: '76643925457-5vfh8kpdqbffkudsn0j02o6sara0c2sq.apps.googleusercontent.com',
    iosBundleId: 'com.example.interviewPrep',
  );
}
