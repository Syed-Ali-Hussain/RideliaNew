import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'airport_user_confirm_model.dart';
export 'airport_user_confirm_model.dart';

class AirportUserConfirmWidget extends StatefulWidget {
  const AirportUserConfirmWidget({
    super.key,
    required this.airportDoc,
  });

  final AirportsRecord? airportDoc;

  @override
  State<AirportUserConfirmWidget> createState() =>
      _AirportUserConfirmWidgetState();
}

class _AirportUserConfirmWidgetState extends State<AirportUserConfirmWidget> {
  late AirportUserConfirmModel _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AirportUserConfirmModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.randNo = await actions.randomNumber();
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: SpinKitRipple(
              color: FlutterFlowTheme.of(context).primary,
              size: 40.0,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 20.0),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Airport nearby',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 25.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: 40.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<ApiCallResponse>(
                            future: DistanceMatrixCall.call(
                              originLocation: functions.locationForDistanceApi(
                                  currentUserLocationValue!),
                              destinationLocation:
                                  functions.locationForDistanceApi(
                                      widget.airportDoc!.location!),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: SpinKitRipple(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                  ),
                                );
                              }
                              final containerDistanceMatrixResponse =
                                  snapshot.data!;

                              return Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      valueOrDefault<String>(
                                        DistanceMatrixCall.distance(
                                          containerDistanceMatrixResponse
                                              .jsonBody,
                                        ),
                                        '0 mi',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.montserrat(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        DistanceMatrixCall.duration(
                                          containerDistanceMatrixResponse
                                              .jsonBody,
                                        ),
                                        '0 min',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.montserrat(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: Text(
                              valueOrDefault<String>(
                                widget.airportDoc?.name,
                                'Airport',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      _model.airportsGot = await queryAirportsRecordOnce(
                        queryBuilder: (airportsRecord) => airportsRecord.where(
                          'placeId',
                          isEqualTo: getJsonField(
                            _model.chosen,
                            r'''$.place_id''',
                          ).toString(),
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (_model.airportsGot != null) {
                        await WaitlistRecord.createDoc(
                                _model.airportsGot!.reference)
                            .set(createWaitlistRecordData(
                          driverId: currentUserDocument?.driverDoc,
                          timeOfJoin: getCurrentTimestamp,
                          assigned: false,
                          leftAfterWaiting: false,
                        ));
                      } else {
                        var airportsRecordReference =
                            AirportsRecord.collection.doc();
                        await airportsRecordReference
                            .set(createAirportsRecordData(
                          name: getJsonField(
                            _model.chosen,
                            r'''$.name''',
                          ).toString(),
                          location: functions.latLongForUpload(getJsonField(
                            _model.chosen,
                            r'''$.location''',
                          )),
                          placeId: getJsonField(
                            _model.chosen,
                            r'''$.place_id''',
                          ).toString(),
                        ));
                        _model.airPortMade = AirportsRecord.getDocumentFromData(
                            createAirportsRecordData(
                              name: getJsonField(
                                _model.chosen,
                                r'''$.name''',
                              ).toString(),
                              location: functions.latLongForUpload(getJsonField(
                                _model.chosen,
                                r'''$.location''',
                              )),
                              placeId: getJsonField(
                                _model.chosen,
                                r'''$.place_id''',
                              ).toString(),
                            ),
                            airportsRecordReference);

                        await WaitlistRecord.createDoc(
                                _model.airPortMade!.reference)
                            .set(createWaitlistRecordData(
                          driverId: currentUserDocument?.driverDoc,
                          timeOfJoin: getCurrentTimestamp,
                          assigned: false,
                          leftAfterWaiting: false,
                        ));
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You have been added to waitlist successfully.',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryText,
                        ),
                      );
                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    text: 'Join Waitlist',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 15.0))
                    .addToStart(SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
