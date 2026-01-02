import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'driver_coming_widget.dart' show DriverComingWidget;
import 'package:flutter/material.dart';

class DriverComingModel extends FlutterFlowModel<DriverComingWidget> {
  ///  Local state fields for this page.

  bool arrived = false;

  ///  State fields for stateful widgets in this page.

  RidesRecord? driverComingPreviousSnapshot;
  // Stores action output result for [Backend Call - Read Document] action in driverComing widget.
  RidesRecord? rideDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
