import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/destinations/destinations_widget.dart';
import '/components/driver_details/driver_details_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'travel_start_model.dart';
export 'travel_start_model.dart';

class TravelStartWidget extends StatefulWidget {
  const TravelStartWidget({super.key});

  static String routeName = 'travelStart';
  static String routePath = '/travelStart';

  @override
  State<TravelStartWidget> createState() => _TravelStartWidgetState();
}

class _TravelStartWidgetState extends State<TravelStartWidget> {
  late TravelStartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TravelStartModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<RidesRecord>(
        stream: RidesRecord.getDocument(currentUserDocument?.rideGoingOn != null
            ? currentUserDocument!.rideGoingOn!
            : FFAppState().tempRide!)
          ..listen((travelStartRidesRecord) async {
            if (_model.travelStartPreviousSnapshot != null &&
                !RidesRecordDocumentEquality().equals(travelStartRidesRecord,
                    _model.travelStartPreviousSnapshot)) {
              await Future.delayed(
                Duration(
                  milliseconds: 1000,
                ),
              );

              context.goNamed(
                BillWidget.routeName,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                  ),
                },
              );

              safeSetState(() {});
            }
            _model.travelStartPreviousSnapshot = travelStartRidesRecord;
          }),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Center(
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

          final travelStartRidesRecord = snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: custom_widgets.MultiPolylineMap(
                        width: double.infinity,
                        height: double.infinity,
                        googleApiKey: FFAppConstants.mapApiKey,
                        polylineColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        polylineWidth: 4,
                        deviationThreshold: 20.0,
                        arrivalThreshold: 40.0,
                        customMapStyle: functions.mapTheme(
                            Theme.of(context).brightness == Brightness.dark),
                        darkMode:
                            Theme.of(context).brightness == Brightness.dark,
                        markerType: 'destination',
                        waypoints: travelStartRidesRecord.destination,
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 15.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await launchUrl(Uri(
                                  scheme: 'tel',
                                  path: '911',
                                ));
                              },
                              text: 'Emergency ',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).error,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: SafeArea(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: DestinationsWidget(
                                              destinationNames:
                                                  travelStartRidesRecord
                                                      .destinationNames,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Container(
                                    width: 130.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Dropoffs',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                font: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Icon(
                                              Icons.expand_less_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 7.0)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 12.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    FFIcons.kmapPinThin,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    await actions.openGoogleMap(
                                      travelStartRidesRecord.start!,
                                      travelStartRidesRecord.destination
                                          .toList(),
                                    );
                                  },
                                ),
                                if (!valueOrDefault<bool>(
                                    currentUserDocument?.driver, false))
                                  FutureBuilder<List<DriversRecord>>(
                                    future: queryDriversRecordOnce(
                                      queryBuilder: (driversRecord) =>
                                          driversRecord.where(
                                        'userId',
                                        isEqualTo:
                                            travelStartRidesRecord.driver,
                                      ),
                                      singleRecord: true,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40.0,
                                            height: 40.0,
                                            child: SpinKitRipple(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 40.0,
                                            ),
                                          ),
                                        );
                                      }
                                      List<DriversRecord>
                                          iconButtonDriversRecordList =
                                          snapshot.data!;
                                      // Return an empty Container when the item does not exist.
                                      if (snapshot.data!.isEmpty) {
                                        return Container();
                                      }
                                      final iconButtonDriversRecord =
                                          iconButtonDriversRecordList.isNotEmpty
                                              ? iconButtonDriversRecordList
                                                  .first
                                              : null;

                                      return FlutterFlowIconButton(
                                        borderRadius: 12.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        icon: Icon(
                                          FFIcons.kcarSimpleThin,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: DriverDetailsWidget(
                                                    driver:
                                                        iconButtonDriversRecord!,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                      );
                                    },
                                  ),
                                if (valueOrDefault<bool>(
                                    currentUserDocument?.driver, false))
                                  FFButtonWidget(
                                    onPressed: () async {
                                      currentUserLocationValue =
                                          await getCurrentUserLocation(
                                              defaultLocation:
                                                  LatLng(0.0, 0.0));
                                      var _shouldSetState = false;
                                      if (!FFAppState().destinationReached) {
                                        _model.arrived =
                                            await actions.driverIsNear(
                                          travelStartRidesRecord
                                              .destination.lastOrNull!,
                                          currentUserLocationValue!,
                                          100.0,
                                        );
                                        _shouldSetState = true;
                                        if (!_model.arrived!) {
                                          var confirmDialogResponse =
                                              await showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Are you sure?'),
                                                        content: Text(
                                                            'The system shows you are more than 100 meters away from the destination. Confirm if you want to mark yourself as arrived anyway?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    false),
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    true),
                                                            child:
                                                                Text('Confirm'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ) ??
                                                  false;
                                          if (!confirmDialogResponse) {
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }
                                        }
                                      }
                                      _model.rideTypeDoc =
                                          await RideTypesRecord.getDocumentOnce(
                                              travelStartRidesRecord.rideType!);
                                      _shouldSetState = true;
                                      _model.distancesApi =
                                          await DistanceWithWayPointsCall.call(
                                        start: functions.locationForDistanceApi(
                                            travelStartRidesRecord.start!),
                                        destination:
                                            functions.locationForDistanceApi(
                                                travelStartRidesRecord
                                                    .destination.lastOrNull!),
                                        wayPoints:
                                            functions.wayPointsForDistanceApi(
                                                travelStartRidesRecord
                                                    .destination
                                                    .toList()),
                                      );

                                      _shouldSetState = true;

                                      await currentUserDocument!.rideGoingOn!
                                          .update(createRidesRecordData(
                                        endTime: getCurrentTimestamp,
                                        completedButNotPaid: true,
                                        basicFare:
                                            _model.rideTypeDoc?.basePrice,
                                        timeFare: functions.durationPrice(
                                            travelStartRidesRecord.pickupTime!,
                                            getCurrentTimestamp,
                                            _model.rideTypeDoc!.pricePerMinute),
                                        waitTimeAtPickupFare:
                                            functions.durationPrice(
                                                travelStartRidesRecord
                                                    .driverArriveTime!,
                                                travelStartRidesRecord
                                                    .pickupTime!,
                                                _model.rideTypeDoc!
                                                    .pricePerMinuteBeforePickup),
                                        distanceFare: functions.distancePrice(
                                            DistanceWithWayPointsCall
                                                    .distancesValues(
                                              (_model.distancesApi?.jsonBody ??
                                                  ''),
                                            )!
                                                .toList(),
                                            _model.rideTypeDoc!.pricePerMile),
                                      ));

                                      context.goNamed(
                                        BillWidget.routeName,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );

                                      if (_shouldSetState) safeSetState(() {});
                                    },
                                    text: 'Complete Ride',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                              ].divide(SizedBox(width: 7.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
