import '/components/user_info/user_info_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'driver_details_widget.dart' show DriverDetailsWidget;
import 'package:flutter/material.dart';

class DriverDetailsModel extends FlutterFlowModel<DriverDetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for userInfo component.
  late UserInfoModel userInfoModel;

  @override
  void initState(BuildContext context) {
    userInfoModel = createModel(context, () => UserInfoModel());
  }

  @override
  void dispose() {
    userInfoModel.dispose();
  }
}
