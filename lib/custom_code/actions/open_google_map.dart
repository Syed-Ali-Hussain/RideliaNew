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

import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMap(
  LatLng origin,
  List<LatLng> destinations,
) async {
  if (destinations.isEmpty) {
    throw 'Destination list cannot be empty';
  }

  // Final destination = last point
  final LatLng finalDestination = destinations.last;

  // Waypoints = everything except last
  final List<LatLng> waypoints = destinations.length > 1
      ? destinations.sublist(0, destinations.length - 1)
      : [];

  // Build waypoints string
  final String waypointsString =
      waypoints.map((e) => '${e.latitude},${e.longitude}').join('|');

  final String url = waypoints.isNotEmpty
      ? 'https://www.google.com/maps/dir/?api=1'
          '&origin=${origin.latitude},${origin.longitude}'
          '&destination=${finalDestination.latitude},${finalDestination.longitude}'
          '&waypoints=$waypointsString'
          '&travelmode=driving'
      : 'https://www.google.com/maps/dir/?api=1'
          '&origin=${origin.latitude},${origin.longitude}'
          '&destination=${finalDestination.latitude},${finalDestination.longitude}'
          '&travelmode=driving';

  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open Google Maps';
  }
}
