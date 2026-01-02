import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'bill_widget.dart' show BillWidget;
import 'package:flutter/material.dart';

class BillModel extends FlutterFlowModel<BillWidget> {
  ///  Local state fields for this page.

  double? payable;

  PromoCodesRecord? promoUsedGot;

  bool promoUsed = false;

  double? totalRideAmount = 0.0;

  ///  State fields for stateful widgets in this page.

  RidesRecord? billPreviousSnapshot;
  // Stores action output result for [Backend Call - Read Document] action in bill widget.
  RidesRecord? rideForDiscount;
  // Stores action output result for [Backend Call - Read Document] action in bill widget.
  PromoCodesRecord? promoUsedDoc;
  // State field(s) for Slider widget.
  double? sliderValue;
  // Stores action output result for [Bottom Sheet - email] action in Button widget.
  String? emailGot;
  // Stores action output result for [Stripe Payment] action in Button widget.
  String? paymentId;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  RideTypesRecord? rideTypeDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
