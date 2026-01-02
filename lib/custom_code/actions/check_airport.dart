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

import 'package:geolocator/geolocator.dart';

Future<AirportsRecord?> checkAirport(
  List<AirportsRecord>? allPorts,
  LatLng orderLocation,
) async {
  if (allPorts == null || allPorts.isEmpty) return null;

  const double defaultRadiusMeters = 5000; // adjust per airport if needed

  for (final airport in allPorts) {
    final geo = airport.location;
    if (geo == null) continue;

    final distance = Geolocator.distanceBetween(
      orderLocation.latitude,
      orderLocation.longitude,
      geo.latitude,
      geo.longitude,
    );

    if (distance <= defaultRadiusMeters) {
      return airport; // Found the airport near the order location
    }
  }

  return null; // No airport nearby
}
