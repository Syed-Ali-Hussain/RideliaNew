import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cancel_ride_driver_model.dart';
export 'cancel_ride_driver_model.dart';

class CancelRideDriverWidget extends StatefulWidget {
  const CancelRideDriverWidget({super.key});

  @override
  State<CancelRideDriverWidget> createState() => _CancelRideDriverWidgetState();
}

class _CancelRideDriverWidgetState extends State<CancelRideDriverWidget> {
  late CancelRideDriverModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CancelRideDriverModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 20.0),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cancel Ride?',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 25.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Are you sure you want to cancel your ride?',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.raleway(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Close',
                        options: FFButtonOptions(
                          width: 100.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryText,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          _model.rideGot = await RidesRecord.getDocumentOnce(
                              currentUserDocument!.reservedRide!);
                          _model.waitingFeesDoc = await queryChargesRecordOnce(
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          // Passenger Deduction For Wait

                          await _model.rideGot!.customer!.update({
                            ...mapToFirestore(
                              {
                                'coins': FieldValue.increment(-(_model
                                    .waitingFeesDoc!.passengerWaitingFee)),
                              },
                            ),
                          });

                          await RechargeHistoryRecord.createDoc(
                                  _model.rideGot!.customer!)
                              .set(createRechargeHistoryRecordData(
                            date: getCurrentTimestamp,
                            amount: _model.waitingFeesDoc?.passengerWaitingFee,
                            rideRef: currentUserDocument?.rideGoingOn,
                            details: 'No-Show Fee Deducted',
                          ));
                          // Driver Get Money For Waiting

                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'coins': FieldValue.increment(
                                    _model.waitingFeesDoc!.driverWaitingFee),
                              },
                            ),
                          });

                          await RechargeHistoryRecord.createDoc(
                                  currentUserReference!)
                              .set(createRechargeHistoryRecordData(
                            date: getCurrentTimestamp,
                            amount: _model.waitingFeesDoc?.driverWaitingFee,
                            user: currentUserReference,
                            rideRef: currentUserDocument?.rideGoingOn,
                            details: 'Cancellation Fee Credited',
                          ));

                          await currentUserDocument!.rideGoingOn!
                              .update(createRidesRecordData(
                            canceled: true,
                          ));

                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'rideGoingOn': FieldValue.delete(),
                              },
                            ),
                          });
                          FFAppState().remainingDistance = 0.0;
                          FFAppState().destinationReached = false;
                          FFAppState().ridePlaced = false;
                          FFAppState().tempRide = null;
                          safeSetState(() {});

                          context.goNamed(
                            HomeWidget.routeName,
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                              ),
                            },
                          );

                          safeSetState(() {});
                        },
                        text: 'Cancel Ride',
                        options: FFButtonOptions(
                          width: 100.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).error,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 15.0)),
                ),
              ]
                  .divide(SizedBox(height: 20.0))
                  .addToStart(SizedBox(height: 10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
