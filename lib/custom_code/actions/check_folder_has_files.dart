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

import 'package:firebase_storage/firebase_storage.dart';

Future<bool> checkFolderHasFiles(String? subDirectory, int number) async {
  if (subDirectory == null || subDirectory.isEmpty) {
    print('Invalid subDirectory');
    return false;
  }

  try {
    final ref = FirebaseStorage.instance.ref('user_documents/$subDirectory');

    // List up to 4 items (no need to fetch all)
    final listResult = await ref.list(ListOptions(maxResults: number));

    // Check if there are 4 or more files
    if (listResult.items.length >= number) {
      return true;
    } else {
      print('Only ${listResult.items.length} files found in $subDirectory');
      return false;
    }
  } catch (e) {
    print('Error checking folder: $e');
    return false;
  }
}
