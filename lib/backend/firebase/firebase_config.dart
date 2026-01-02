import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAoX0whbG4Ju2wKVG15rue7yxOn9Ilq-ls",
            authDomain: "ridelia-4876c.firebaseapp.com",
            projectId: "ridelia-4876c",
            storageBucket: "ridelia-4876c.firebasestorage.app",
            messagingSenderId: "828020061798",
            appId: "1:828020061798:web:b26a759cd68e32b0c15fa7"));
  } else {
    await Firebase.initializeApp();
  }
}
