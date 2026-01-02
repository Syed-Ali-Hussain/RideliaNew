import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'cancel_ride_driver_widget.dart' show CancelRideDriverWidget;
import 'package:flutter/material.dart';

class CancelRideDriverModel extends FlutterFlowModel<CancelRideDriverWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  RidesRecord? rideGot;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChargesRecord? waitingFeesDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
