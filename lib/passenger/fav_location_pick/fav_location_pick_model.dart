import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'fav_location_pick_widget.dart' show FavLocationPickWidget;
import 'package:flutter/material.dart';

class FavLocationPickModel extends FlutterFlowModel<FavLocationPickWidget> {
  ///  Local state fields for this component.

  List<dynamic> locationsGot = [];
  void addToLocationsGot(dynamic item) => locationsGot.add(item);
  void removeFromLocationsGot(dynamic item) => locationsGot.remove(item);
  void removeAtIndexFromLocationsGot(int index) => locationsGot.removeAt(index);
  void insertAtIndexInLocationsGot(int index, dynamic item) =>
      locationsGot.insert(index, item);
  void updateLocationsGotAtIndex(int index, Function(dynamic) updateFn) =>
      locationsGot[index] = updateFn(locationsGot[index]);

  String? sessionUUID;

  bool chosen = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - randomNumber] action in favLocationPick widget.
  String? uuid;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Places Autocomplete)] action in TextField widget.
  ApiCallResponse? apiResultizz;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
