import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - safeQuery] action in Home widget.
  RidesRecord? rideGot;
  // Stores action output result for [Backend Call - Read Document] action in Home widget.
  DriversRecord? driverDoc;
  // Stores action output result for [Backend Call - Read Document] action in Home widget.
  RidesRecord? reservationDriver;
  // Stores action output result for [Custom Action - safeQuery] action in Home widget.
  RidesRecord? scheduled;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  // Stores action output result for [Backend Call - Read Document] action in IconButton widget.
  AirportsRecord? airportGot;
  // Stores action output result for [Backend Call - API (Airports)] action in IconButton widget.
  ApiCallResponse? airports;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
