import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'travel_start_widget.dart' show TravelStartWidget;
import 'package:flutter/material.dart';

class TravelStartModel extends FlutterFlowModel<TravelStartWidget> {
  ///  Local state fields for this page.

  bool isHere = false;

  ///  State fields for stateful widgets in this page.

  RidesRecord? travelStartPreviousSnapshot;
  // Stores action output result for [Custom Action - driverIsNear] action in Button widget.
  bool? arrived;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  RideTypesRecord? rideTypeDoc;
  // Stores action output result for [Backend Call - API (Distance with WayPoints)] action in Button widget.
  ApiCallResponse? distancesApi;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
