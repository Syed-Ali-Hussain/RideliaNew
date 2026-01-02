import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'verify_phone_number_sign_up_widget.dart'
    show VerifyPhoneNumberSignUpWidget;
import 'package:flutter/material.dart';

class VerifyPhoneNumberSignUpModel
    extends FlutterFlowModel<VerifyPhoneNumberSignUpWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Custom Action - verifyAndLinkOtpAction] action in Button widget.
  String? verified;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }
}
