import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/air_port_confirm/air_port_confirm_widget.dart';
import '/components/select_ride_type/select_ride_type_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ride_preview_model.dart';
export 'ride_preview_model.dart';

class RidePreviewWidget extends StatefulWidget {
  const RidePreviewWidget({
    super.key,
    required this.reserve,
    this.reserveFor,
    this.rideType,
  });

  final bool? reserve;
  final DateTime? reserveFor;
  final DocumentReference? rideType;

  static String routeName = 'ridePreview';
  static String routePath = '/ridePreview';

  @override
  State<RidePreviewWidget> createState() => _RidePreviewWidgetState();
}

class _RidePreviewWidgetState extends State<RidePreviewWidget>
    with TickerProviderStateMixin {
  late RidePreviewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RidePreviewModel());

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          TiltEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0, 0),
            end: Offset(0, 3.142),
          ),
          TintEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).error,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Ride Preview',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.montserrat(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 25.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: custom_widgets.Alimap(
                      width: double.infinity,
                      height: double.infinity,
                      polylineWidth: 4.0,
                      apiKey: FFAppConstants.mapApiKey,
                      polylineColor: FlutterFlowTheme.of(context).secondaryText,
                      latlongs: FFAppState().allPoints,
                      mapThemeString: functions.mapTheme(
                          Theme.of(context).brightness == Brightness.dark),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.all(10.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      var _shouldSetState = false;
                      if (animationsMap['iconOnActionTriggerAnimation'] !=
                          null) {
                        await animationsMap['iconOnActionTriggerAnimation']!
                            .controller
                          ..reset()
                          ..repeat(reverse: true);
                      }
                      _model.distancesApi =
                          await DistanceWithWayPointsCall.call(
                        start: functions.locationForDistanceApi(
                            FFAppState().origin.latLngs!),
                        destination: functions.locationForDistanceApi(
                            FFAppState().destinations.lastOrNull!.latLngs!),
                        wayPoints: functions.wayPointsForDistanceApi(
                            FFAppState()
                                .destinations
                                .map((e) => e.latLngs)
                                .withoutNulls
                                .toList()),
                      );

                      _shouldSetState = true;
                      if ((_model.distancesApi?.succeeded ?? true)) {
                        if (widget.rideType != null) {
                          _model.rideChosen = widget.rideType;
                          safeSetState(() {});
                        } else {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: SelectRideTypeWidget(
                                    timeDurations: DistanceWithWayPointsCall
                                        .durationsValues(
                                      (_model.distancesApi?.jsonBody ?? ''),
                                    ),
                                    distances: DistanceWithWayPointsCall
                                        .distancesValues(
                                      (_model.distancesApi?.jsonBody ?? ''),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).then((value) =>
                              safeSetState(() => _model.rideSelected = value));

                          _shouldSetState = true;
                          if (!(_model.rideSelected != null)) {
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          }
                          _model.rideChosen = _model.rideSelected?.reference;
                          safeSetState(() {});
                        }

                        _model.rideTypeChosen =
                            await RideTypesRecord.getDocumentOnce(
                                _model.rideChosen!);
                        _shouldSetState = true;
                        _model.allAirports = await queryAirportsRecordOnce();
                        _shouldSetState = true;
                        _model.relevantAirport = await actions.checkAirport(
                          _model.allAirports?.toList(),
                          FFAppState().origin.latLngs!,
                        );
                        _shouldSetState = true;
                        if (_model.relevantAirport != null) {
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: AirPortConfirmWidget(
                                    name: _model.relevantAirport!.name,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(
                              () => _model.bottomSheetAirPort = value));

                          _shouldSetState = true;
                          if (_model.bottomSheetAirPort!) {
                            _model.airPortDrivers =
                                await queryDriversRecordOnce(
                              queryBuilder: (driversRecord) => driversRecord
                                  .where(
                                    'isOnline',
                                    isEqualTo: true,
                                  )
                                  .where(
                                    'vehicleTypesOffering',
                                    arrayContains: _model.rideChosen,
                                  )
                                  .where(
                                    'waitingAtAirport',
                                    isEqualTo: true,
                                  )
                                  .where(
                                    'whichAirport',
                                    isEqualTo:
                                        _model.relevantAirport?.reference,
                                  ),
                            );
                            _shouldSetState = true;
                            triggerPushNotification(
                              notificationTitle: 'Your turn in queue!',
                              notificationText:
                                  'A new ride is available for you.',
                              notificationSound: 'default',
                              userRefs: _model.airPortDrivers!
                                  .map((e) => e.userId)
                                  .withoutNulls
                                  .toList(),
                              initialPageName: 'Home',
                              parameterData: {},
                            );

                            var ridesRecordReference1 =
                                RidesRecord.collection.doc();
                            await ridesRecordReference1.set({
                              ...createRidesRecordData(
                                paid: false,
                                startTime: getCurrentTimestamp,
                                customer: currentUserReference,
                                rideType: _model.rideChosen,
                                accepted: false,
                                start: FFAppState().origin.latLngs,
                                completedButNotPaid: false,
                                started: false,
                                canceled: false,
                                airportRide: true,
                                whichAirport: _model.relevantAirport?.reference,
                                startName: _model.relevantAirport?.name,
                                basicFare: _model.rideTypeChosen?.basePrice,
                                distanceFare: functions.distancePrice(
                                    DistanceWithWayPointsCall.distancesValues(
                                      (_model.distancesApi?.jsonBody ?? ''),
                                    )!
                                        .toList(),
                                    _model.rideTypeChosen!.pricePerMile),
                                timeFare: functions.estimatedTimePrice(
                                    DistanceWithWayPointsCall.durationsValues(
                                      (_model.distancesApi?.jsonBody ?? ''),
                                    )!
                                        .toList(),
                                    _model.rideTypeChosen!.pricePerMinute),
                                waitTimeAtPickupFare: 0.0,
                                reservation: widget.reserve,
                                reservationTime: widget.reserveFor,
                                promoCodeUsed: FFAppState().promoCodeUsed,
                              ),
                              ...mapToFirestore(
                                {
                                  'destination': convertToGeoPointList(
                                      FFAppState()
                                          .destinations
                                          .map((e) => e.latLngs)
                                          .withoutNulls
                                          .toList()),
                                  'destinationNames': FFAppState()
                                      .destinations
                                      .map((e) => e.title)
                                      .toList(),
                                },
                              ),
                            });
                            _model.rideCreatedAirPort =
                                RidesRecord.getDocumentFromData({
                              ...createRidesRecordData(
                                paid: false,
                                startTime: getCurrentTimestamp,
                                customer: currentUserReference,
                                rideType: _model.rideChosen,
                                accepted: false,
                                start: FFAppState().origin.latLngs,
                                completedButNotPaid: false,
                                started: false,
                                canceled: false,
                                airportRide: true,
                                whichAirport: _model.relevantAirport?.reference,
                                startName: _model.relevantAirport?.name,
                                basicFare: _model.rideTypeChosen?.basePrice,
                                distanceFare: functions.distancePrice(
                                    DistanceWithWayPointsCall.distancesValues(
                                      (_model.distancesApi?.jsonBody ?? ''),
                                    )!
                                        .toList(),
                                    _model.rideTypeChosen!.pricePerMile),
                                timeFare: functions.estimatedTimePrice(
                                    DistanceWithWayPointsCall.durationsValues(
                                      (_model.distancesApi?.jsonBody ?? ''),
                                    )!
                                        .toList(),
                                    _model.rideTypeChosen!.pricePerMinute),
                                waitTimeAtPickupFare: 0.0,
                                reservation: widget.reserve,
                                reservationTime: widget.reserveFor,
                                promoCodeUsed: FFAppState().promoCodeUsed,
                              ),
                              ...mapToFirestore(
                                {
                                  'destination': convertToGeoPointList(
                                      FFAppState()
                                          .destinations
                                          .map((e) => e.latLngs)
                                          .withoutNulls
                                          .toList()),
                                  'destinationNames': FFAppState()
                                      .destinations
                                      .map((e) => e.title)
                                      .toList(),
                                },
                              ),
                            }, ridesRecordReference1);
                            _shouldSetState = true;

                            await currentUserReference!.update({
                              ...mapToFirestore(
                                {
                                  'rideHistory': FieldValue.arrayUnion(
                                      [_model.rideCreatedAirPort?.reference]),
                                },
                              ),
                            });
                            if (animationsMap['iconOnActionTriggerAnimation'] !=
                                null) {
                              animationsMap['iconOnActionTriggerAnimation']!
                                  .controller
                                  .stop();
                            }
                            if (widget.reserve!) {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                reservedRide:
                                    _model.rideCreatedAirPort?.reference,
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Reservation order placed successfully.',
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

                              context.goNamed(
                                HomeWidget.routeName,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                  ),
                                },
                              );
                            } else {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                rideGoingOn:
                                    _model.rideCreatedAirPort?.reference,
                              ));
                              FFAppState().destinationReached = false;
                              FFAppState().remainingDistance = 0.0;
                              FFAppState().ridePlaced = true;
                              FFAppState().tempRide =
                                  _model.rideCreatedAirPort?.reference;
                              safeSetState(() {});

                              context.goNamed(
                                SearchingDriverWidget.routeName,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                  ),
                                },
                              );
                            }

                            if (_shouldSetState) safeSetState(() {});
                            return;
                          }
                        }
                        _model.relevantDriver = await queryDriversRecordOnce(
                          queryBuilder: (driversRecord) => driversRecord
                              .where(
                                'vehicleTypesOffering',
                                arrayContains: _model.rideChosen,
                              )
                              .where(
                                'waitingAtAirport',
                                isEqualTo: false,
                              )
                              .where(
                                'isOnline',
                                isEqualTo: true,
                              ),
                        );
                        _shouldSetState = true;
                        triggerPushNotification(
                          notificationTitle: 'New Ride!',
                          notificationText: 'A new ride is available for you.',
                          notificationSound: 'default',
                          userRefs: _model.relevantDriver!
                              .map((e) => e.userId)
                              .withoutNulls
                              .toList(),
                          initialPageName: 'Home',
                          parameterData: {},
                        );

                        var ridesRecordReference2 =
                            RidesRecord.collection.doc();
                        await ridesRecordReference2.set({
                          ...createRidesRecordData(
                            paid: false,
                            startTime: getCurrentTimestamp,
                            customer: currentUserReference,
                            rideType: _model.rideChosen,
                            accepted: false,
                            start: FFAppState().origin.latLngs,
                            completedButNotPaid: false,
                            started: false,
                            canceled: false,
                            airportRide: false,
                            startName: FFAppState().origin.title,
                            basicFare: _model.rideTypeChosen?.basePrice,
                            distanceFare: functions.distancePrice(
                                DistanceWithWayPointsCall.distancesValues(
                                  (_model.distancesApi?.jsonBody ?? ''),
                                )!
                                    .toList(),
                                _model.rideTypeChosen!.pricePerMile),
                            timeFare: functions.estimatedTimePrice(
                                DistanceWithWayPointsCall.durationsValues(
                                  (_model.distancesApi?.jsonBody ?? ''),
                                )!
                                    .toList(),
                                _model.rideTypeChosen!.pricePerMinute),
                            waitTimeAtPickupFare: 0.0,
                            reservation: widget.reserve,
                            reservationTime: widget.reserveFor,
                            promoCodeUsed: FFAppState().promoCodeUsed,
                          ),
                          ...mapToFirestore(
                            {
                              'destination': convertToGeoPointList(FFAppState()
                                  .destinations
                                  .map((e) => e.latLngs)
                                  .withoutNulls
                                  .toList()),
                              'destinationNames': FFAppState()
                                  .destinations
                                  .map((e) => e.title)
                                  .toList(),
                            },
                          ),
                        });
                        _model.rideCreated = RidesRecord.getDocumentFromData({
                          ...createRidesRecordData(
                            paid: false,
                            startTime: getCurrentTimestamp,
                            customer: currentUserReference,
                            rideType: _model.rideChosen,
                            accepted: false,
                            start: FFAppState().origin.latLngs,
                            completedButNotPaid: false,
                            started: false,
                            canceled: false,
                            airportRide: false,
                            startName: FFAppState().origin.title,
                            basicFare: _model.rideTypeChosen?.basePrice,
                            distanceFare: functions.distancePrice(
                                DistanceWithWayPointsCall.distancesValues(
                                  (_model.distancesApi?.jsonBody ?? ''),
                                )!
                                    .toList(),
                                _model.rideTypeChosen!.pricePerMile),
                            timeFare: functions.estimatedTimePrice(
                                DistanceWithWayPointsCall.durationsValues(
                                  (_model.distancesApi?.jsonBody ?? ''),
                                )!
                                    .toList(),
                                _model.rideTypeChosen!.pricePerMinute),
                            waitTimeAtPickupFare: 0.0,
                            reservation: widget.reserve,
                            reservationTime: widget.reserveFor,
                            promoCodeUsed: FFAppState().promoCodeUsed,
                          ),
                          ...mapToFirestore(
                            {
                              'destination': convertToGeoPointList(FFAppState()
                                  .destinations
                                  .map((e) => e.latLngs)
                                  .withoutNulls
                                  .toList()),
                              'destinationNames': FFAppState()
                                  .destinations
                                  .map((e) => e.title)
                                  .toList(),
                            },
                          ),
                        }, ridesRecordReference2);
                        _shouldSetState = true;

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'rideHistory': FieldValue.arrayUnion(
                                  [_model.rideCreated?.reference]),
                            },
                          ),
                        });
                        if (animationsMap['iconOnActionTriggerAnimation'] !=
                            null) {
                          animationsMap['iconOnActionTriggerAnimation']!
                              .controller
                              .stop();
                        }
                        if (widget.reserve!) {
                          await currentUserReference!
                              .update(createUsersRecordData(
                            reservedRide: _model.rideCreated?.reference,
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Reservation order placed successfully.',
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

                          context.goNamed(
                            HomeWidget.routeName,
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                              ),
                            },
                          );
                        } else {
                          await currentUserReference!
                              .update(createUsersRecordData(
                            rideGoingOn: _model.rideCreated?.reference,
                          ));
                          FFAppState().destinationReached = false;
                          FFAppState().remainingDistance = 0.0;
                          FFAppState().ridePlaced = true;
                          FFAppState().tempRide = _model.rideCreated?.reference;
                          safeSetState(() {});

                          context.goNamed(
                            SearchingDriverWidget.routeName,
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                              ),
                            },
                          );
                        }
                      } else {
                        if (animationsMap['iconOnActionTriggerAnimation'] !=
                            null) {
                          animationsMap['iconOnActionTriggerAnimation']!
                              .controller
                              .stop();
                        }
                        _model.tapped = false;
                        safeSetState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Connectivity error. Please try again later.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }

                      if (_shouldSetState) safeSetState(() {});
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryText,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!_model.tapped)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    'Place Ride',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.raleway(
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
                                              .primaryBackground,
                                          fontSize: 16.0,
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
                                ),
                              if (_model.tapped)
                                Text(
                                  'Placing ride...',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.raleway(
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
                                            .primaryBackground,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              Icon(
                                FFIcons.kflowArrowThin,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 24.0,
                              ).animateOnActionTrigger(
                                animationsMap['iconOnActionTriggerAnimation']!,
                              ),
                            ].divide(SizedBox(width: 10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
