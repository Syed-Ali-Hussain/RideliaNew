import '/backend/backend.dart';
import '/components/select_car_type/select_car_type_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'select_ride_type_widget.dart' show SelectRideTypeWidget;
import 'package:flutter/material.dart';

class SelectRideTypeModel extends FlutterFlowModel<SelectRideTypeWidget> {
  ///  Local state fields for this component.

  RideTypesRecord? selected;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  PromoCodesRecord? docGotPromo;
  // Models for selectCarType dynamic component.
  late FlutterFlowDynamicModels<SelectCarTypeModel> selectCarTypeModels;

  @override
  void initState(BuildContext context) {
    selectCarTypeModels = FlutterFlowDynamicModels(() => SelectCarTypeModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    selectCarTypeModels.dispose();
  }
}
