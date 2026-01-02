import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'fav_location_widget.dart' show FavLocationWidget;
import 'package:flutter/material.dart';

class FavLocationModel extends FlutterFlowModel<FavLocationWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - randomNumber] action in Button widget.
  String? uuid;
  // Stores action output result for [Bottom Sheet - pickUp] action in Button widget.
  LocationChosenStruct? pickUpGot;
  // Stores action output result for [Bottom Sheet - selectRideType] action in Button widget.
  RideTypesRecord? rideTypeSelected;
  // Stores action output result for [Backend Call - API (Distance Matrix)] action in Button widget.
  ApiCallResponse? distanceMatrixResponse;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<AirportsRecord>? allAirports;
  // Stores action output result for [Custom Action - checkAirport] action in Button widget.
  AirportsRecord? relevantAirport;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? airPortConfirmed;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  RidesRecord? rideCreatedAirPort;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DriversRecord>? driversGotAirPort;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  RidesRecord? rideCreated;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DriversRecord>? driversGot;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
