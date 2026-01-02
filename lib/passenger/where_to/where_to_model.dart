import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'where_to_widget.dart' show WhereToWidget;
import 'package:flutter/material.dart';

class WhereToModel extends FlutterFlowModel<WhereToWidget> {
  ///  Local state fields for this page.

  String? sessionTokenUUID;

  DateTime? timeForReservation;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - randomNumber] action in whereTo widget.
  String? sessionToken;
  // Stores action output result for [Bottom Sheet - pickUp] action in whereTo widget.
  LocationChosenStruct? pickUpChosen;
  // Stores action output result for [Bottom Sheet - dropoff] action in whereTo widget.
  LocationChosenStruct? firstDropoff;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  DateTime? datePicked;
  // Stores action output result for [Bottom Sheet - pickUp] action in IconButton widget.
  LocationChosenStruct? newPickup;
  // Stores action output result for [Bottom Sheet - dropoff] action in Button widget.
  LocationChosenStruct? dropoffgot;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
