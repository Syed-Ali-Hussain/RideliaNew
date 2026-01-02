import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'ride_preview_widget.dart' show RidePreviewWidget;
import 'package:flutter/material.dart';

class RidePreviewModel extends FlutterFlowModel<RidePreviewWidget> {
  ///  Local state fields for this page.

  bool tapped = false;

  double? discountedBill;

  String? codeUsed;

  DocumentReference? rideChosen;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Distance with WayPoints)] action in Container widget.
  ApiCallResponse? distancesApi;
  // Stores action output result for [Bottom Sheet - selectRideType] action in Container widget.
  RideTypesRecord? rideSelected;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  RideTypesRecord? rideTypeChosen;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<AirportsRecord>? allAirports;
  // Stores action output result for [Custom Action - checkAirport] action in Container widget.
  AirportsRecord? relevantAirport;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Container widget.
  bool? bottomSheetAirPort;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<DriversRecord>? airPortDrivers;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  RidesRecord? rideCreatedAirPort;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<DriversRecord>? relevantDriver;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  RidesRecord? rideCreated;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
