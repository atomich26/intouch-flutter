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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANTo1Io8xw06Ii1StpJjR-o1ki2VScI1c',
    appId: '1:689580499725:android:2cdeac845f8005d4584644',
    messagingSenderId: '689580499725',
    projectId: 'intouch-c7b87',
    databaseURL: 'https://intouch-c7b87-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'intouch-c7b87.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACHlMalUiWhFrnJ3EUMExJKNuITMgVgO8',
    appId: '1:689580499725:ios:c7305f49c7310c0b584644',
    messagingSenderId: '689580499725',
    projectId: 'intouch-c7b87',
    databaseURL: 'https://intouch-c7b87-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'intouch-c7b87.appspot.com',
    androidClientId: '689580499725-lb4obhhd4vm503tsu5aum24jv8j9oh84.apps.googleusercontent.com',
    iosClientId: '689580499725-0p2sk3g36r1keudbe1lrnsrp23au04am.apps.googleusercontent.com',
    iosBundleId: 'com.example.intouch',
  );
}
