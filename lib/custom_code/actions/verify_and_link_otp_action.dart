// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

Future<String> verifyAndLinkOtpAction(
  String verificationId,
  String smsCode,
) async {
  try {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.linkWithCredential(credential);
      return "success";
    } else {
      return "no-current-user";
    }
  } on FirebaseAuthException catch (e) {
    return e.code; // return raw code
  } catch (e) {
    return e.toString();
  }
}
