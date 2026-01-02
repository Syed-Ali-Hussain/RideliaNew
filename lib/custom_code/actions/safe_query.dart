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

Future<RidesRecord?> safeQuery(DocumentReference documentRefToSearch) async {
  try {
    final snapshot = await documentRefToSearch.get();

    // If document doesn't exist or has no data → return null
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return RidesRecord.fromSnapshot(snapshot);
  } catch (e, st) {
    // Log error for debugging
    debugPrint('safeQuery error: $e\n$st');
    return null;
  }
}
