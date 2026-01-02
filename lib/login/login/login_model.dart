import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextFieldEmail widget.
  FocusNode? textFieldEmailFocusNode;
  TextEditingController? textFieldEmailTextController;
  String? Function(BuildContext, String?)?
      textFieldEmailTextControllerValidator;
  // State field(s) for TextFieldPass widget.
  FocusNode? textFieldPassFocusNode;
  TextEditingController? textFieldPassTextController;
  late bool textFieldPassVisibility;
  String? Function(BuildContext, String?)? textFieldPassTextControllerValidator;
  // Stores action output result for [Bottom Sheet - phoneNumber] action in Button widget.
  String? phoneNumber;

  @override
  void initState(BuildContext context) {
    textFieldPassVisibility = false;
  }

  @override
  void dispose() {
    textFieldEmailFocusNode?.dispose();
    textFieldEmailTextController?.dispose();

    textFieldPassFocusNode?.dispose();
    textFieldPassTextController?.dispose();
  }
}
