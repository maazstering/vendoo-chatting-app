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
    apiKey:
        'AIzaSyCxZ-1e4LBtxYpi82i86yTRjl9NBgu1I-k', //AIzaSyCth5jQsM3yzaI4O4Silbwy79CB4KbqCXc
    appId:
        '1:119840048542:android:424448d97c606e3cb8028f', //1:575551882451:android:8cf05d8ad4c7616ca1c026
    messagingSenderId: '119840048542', //575551882451
    projectId: 'vendoo-chat', //vendoo-bd009
    storageBucket: 'vendoo-chat.appspot.com', //vendoo-bd009.appspot.com
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBws47ZEtXF86AeEEFRUVAuB0QbHlACK8',
    appId: '1:119840048542:ios:0468c70495f51fa7b8028f',
    messagingSenderId: '119840048542',
    projectId: 'vendoo-chat',
    storageBucket: 'vendoo-chat.appspot.com',
    iosBundleId: 'com.example.vendoo',
  );
}
