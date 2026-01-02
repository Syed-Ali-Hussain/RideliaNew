import '/components/user_info/user_info_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reservation_confirmed_widget.dart' show ReservationConfirmedWidget;
import 'package:flutter/material.dart';

class ReservationConfirmedModel
    extends FlutterFlowModel<ReservationConfirmedWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for userInfo component.
  late UserInfoModel userInfoModel1;
  // Model for userInfo component.
  late UserInfoModel userInfoModel2;

  @override
  void initState(BuildContext context) {
    userInfoModel1 = createModel(context, () => UserInfoModel());
    userInfoModel2 = createModel(context, () => UserInfoModel());
  }

  @override
  void dispose() {
    userInfoModel1.dispose();
    userInfoModel2.dispose();
  }
}
