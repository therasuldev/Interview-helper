import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

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
}
