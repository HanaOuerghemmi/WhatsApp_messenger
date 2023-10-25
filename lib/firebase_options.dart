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
    apiKey: 'AIzaSyAOc3nAwFuUXYZArhPOWFFnkkeE_p2HTwM',
    appId: '1:648875528518:web:b448ff6abd46d2dbb01547',
    messagingSenderId: '648875528518',
    projectId: 'whatsapp-75795',
    authDomain: 'whatsapp-75795.firebaseapp.com',
    storageBucket: 'whatsapp-75795.appspot.com',
    measurementId: 'G-Q9LB8N9YQQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtQg-WHZ_jQpw02HwCmz5t4r44oir2-FM',
    appId: '1:648875528518:android:cbfa305bc50e85bcb01547',
    messagingSenderId: '648875528518',
    projectId: 'whatsapp-75795',
    storageBucket: 'whatsapp-75795.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWaGRCVGAJXls69M_eze4KnvzRRHdrA2Y',
    appId: '1:648875528518:ios:591ac89be129a68bb01547',
    messagingSenderId: '648875528518',
    projectId: 'whatsapp-75795',
    storageBucket: 'whatsapp-75795.appspot.com',
    iosBundleId: 'com.example.whatsappMessenger',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWaGRCVGAJXls69M_eze4KnvzRRHdrA2Y',
    appId: '1:648875528518:ios:f3b068e4cd41622db01547',
    messagingSenderId: '648875528518',
    projectId: 'whatsapp-75795',
    storageBucket: 'whatsapp-75795.appspot.com',
    iosBundleId: 'com.example.whatsappMessenger.RunnerTests',
  );
}
