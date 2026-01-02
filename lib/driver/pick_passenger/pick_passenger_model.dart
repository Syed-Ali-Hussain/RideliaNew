import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'pick_passenger_widget.dart' show PickPassengerWidget;
import 'package:flutter/material.dart';

class PickPassengerModel extends FlutterFlowModel<PickPassengerWidget> {
  ///  Local state fields for this page.

  bool arrived = false;

  bool allowCancel = false;

  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;
  // Stores action output result for [Custom Action - driverIsNear] action in pickPassenger widget.
  bool? yesHere;
  // Stores action output result for [Backend Call - Read Document] action in pickPassenger widget.
  RidesRecord? rideGot;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 300000;
  int timerMilliseconds = 300000;
  String timerValue = StopWatchTimer.getDisplayTime(
    300000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Custom Action - driverIsNear] action in Button widget.
  bool? in200meters;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
    timerController.dispose();
  }
}
