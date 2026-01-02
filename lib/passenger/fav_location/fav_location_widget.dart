import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/air_port_confirm/air_port_confirm_widget.dart';
import '/components/pick_up/pick_up_widget.dart';
import '/components/select_ride_type/select_ride_type_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/passenger/fav_location_pick/fav_location_pick_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fav_location_model.dart';
export 'fav_location_model.dart';

class FavLocationWidget extends StatefulWidget {
  const FavLocationWidget({
    super.key,
    required this.name,
  });

  final String? name;

  @override
  State<FavLocationWidget> createState() => _FavLocationWidgetState();
}

class _FavLocationWidgetState extends State<FavLocationWidget> {
  late FavLocationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavLocationModel());
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.name,
                        'Home',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 30.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AuthUserStreamWidget(
                            builder: (context) => Text(
                              valueOrDefault<String>(
                                (currentUserDocument?.favouriteLocations
                                            .toList() ??
                                        [])
                                    .where((e) => e.name == widget.name)
                                    .toList()
                                    .firstOrNull
                                    ?.address,
                                'Address',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.raleway(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(height: 5.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      builder: (context) => AuthUserStreamWidget(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: FavLocationPickWidget(
                                    locationName: widget.name,
                                  ),
                                );
                              },
                            );

                            safeSetState(() {});
                          },
                          text: (currentUserDocument?.favouriteLocations
                                                  .toList() ??
                                              [])
                                          .where((e) => e.name == widget.name)
                                          .toList()
                                          .firstOrNull
                                          ?.address !=
                                      null &&
                                  (currentUserDocument?.favouriteLocations
                                                  .toList() ??
                                              [])
                                          .where((e) => e.name == widget.name)
                                          .toList()
                                          .firstOrNull
                                          ?.address !=
                                      ''
                              ? 'Edit location'
                              : 'Add location',
                          icon: Icon(
                            Icons.edit_location_alt_outlined,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    if ((currentUserDocument?.favouriteLocations.toList() ??
                                    [])
                                .where((e) => e.name == widget.name)
                                .toList()
                                .firstOrNull
                                ?.address !=
                            null &&
                        (currentUserDocument?.favouriteLocations.toList() ??
                                    [])
                                .where((e) => e.name == widget.name)
                                .toList()
                                .firstOrNull
                                ?.address !=
                            '')
                      Builder(
                        builder: (context) => AuthUserStreamWidget(
                          builder: (context) => FFButtonWidget(
                            onPressed: () async {
                              var _shouldSetState = false;
                              _model.uuid = await actions.randomNumber();
                              _shouldSetState = true;
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: PickUpWidget(
                                      sessionToken: _model.uuid!,
                                    ),
                                  );
                                },
                              ).then((value) =>
                                  safeSetState(() => _model.pickUpGot = value));

                              _shouldSetState = true;
                              if (!(_model.pickUpGot != null)) {
                                Navigator.pop(context);
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                useSafeArea: true,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: SelectRideTypeWidget(),
                                  );
                                },
                              ).then((value) => safeSetState(
                                  () => _model.rideTypeSelected = value));

                              _shouldSetState = true;
                              if (_model.rideTypeSelected?.name != null &&
                                  _model.rideTypeSelected?.name != '') {
                                _model.distanceMatrixResponse =
                                    await DistanceMatrixCall.call(
                                  originLocation:
                                      functions.locationForDistanceApi(
                                          _model.pickUpGot!.latLngs!),
                                  destinationLocation:
                                      functions.placeDetailToDistanceMatrix(
                                          (currentUserDocument
                                                      ?.favouriteLocations
                                                      .toList() ??
                                                  [])
                                              .where(
                                                  (e) => e.name == widget.name)
                                              .toList()
                                              .firstOrNull!
                                              .lat,
                                          (currentUserDocument
                                                      ?.favouriteLocations
                                                      .toList() ??
                                                  [])
                                              .where(
                                                  (e) => e.name == widget.name)
                                              .toList()
                                              .firstOrNull!
                                              .long),
                                );

                                _shouldSetState = true;
                                if ((_model.distanceMatrixResponse?.succeeded ??
                                    true)) {
                                  _model.allAirports =
                                      await queryAirportsRecordOnce();
                                  _shouldSetState = true;
                                  _model.relevantAirport =
                                      await actions.checkAirport(
                                    _model.allAirports?.toList(),
                                    _model.pickUpGot!.latLngs!,
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
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: AirPortConfirmWidget(
                                            name: _model.relevantAirport!.name,
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.airPortConfirmed = value));

                                    _shouldSetState = true;
                                    if (_model.airPortConfirmed!) {
                                      var ridesRecordReference1 =
                                          RidesRecord.collection.doc();
                                      await ridesRecordReference1.set({
                                        ...createRidesRecordData(
                                          paid: false,
                                          startTime: getCurrentTimestamp,
                                          customer: currentUserReference,
                                          rideType: _model
                                              .rideTypeSelected?.reference,
                                          accepted: false,
                                          start: _model.pickUpGot?.latLngs,
                                          completedButNotPaid: false,
                                          started: false,
                                          canceled: false,
                                          startName: _model.pickUpGot?.title,
                                          basicFare: _model
                                              .rideTypeSelected?.basePrice,
                                          distanceFare:
                                              ((DistanceMatrixCall.distanceInt(
                                                        (_model.distanceMatrixResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!) /
                                                      1609.34) *
                                                  _model.rideTypeSelected!
                                                      .pricePerMile,
                                          timeFare:
                                              ((DistanceMatrixCall.durationInt(
                                                        (_model.distanceMatrixResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!) /
                                                      60) *
                                                  _model.rideTypeSelected!
                                                      .pricePerMinute,
                                          waitTimeAtPickupFare: 0.0,
                                          airportRide: true,
                                          whichAirport:
                                              _model.relevantAirport?.reference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'destination': [
                                              functions
                                                  .doublesToLatLong(
                                                      (currentUserDocument
                                                                  ?.favouriteLocations
                                                                  .toList() ??
                                                              [])
                                                          .where((e) =>
                                                              e.name ==
                                                              widget.name)
                                                          .toList()
                                                          .firstOrNull!
                                                          .lat,
                                                      (currentUserDocument
                                                                  ?.favouriteLocations
                                                                  .toList() ??
                                                              [])
                                                          .where((e) =>
                                                              e.name ==
                                                              widget.name)
                                                          .toList()
                                                          .firstOrNull!
                                                          .long)
                                                  .toGeoPoint()
                                            ],
                                            'destinationNames': [
                                              (currentUserDocument
                                                          ?.favouriteLocations
                                                          .toList() ??
                                                      [])
                                                  .where((e) =>
                                                      e.name == widget.name)
                                                  .toList()
                                                  .firstOrNull
                                                  ?.address
                                            ],
                                          },
                                        ),
                                      });
                                      _model.rideCreatedAirPort =
                                          RidesRecord.getDocumentFromData({
                                        ...createRidesRecordData(
                                          paid: false,
                                          startTime: getCurrentTimestamp,
                                          customer: currentUserReference,
                                          rideType: _model
                                              .rideTypeSelected?.reference,
                                          accepted: false,
                                          start: _model.pickUpGot?.latLngs,
                                          completedButNotPaid: false,
                                          started: false,
                                          canceled: false,
                                          startName: _model.pickUpGot?.title,
                                          basicFare: _model
                                              .rideTypeSelected?.basePrice,
                                          distanceFare:
                                              ((DistanceMatrixCall.distanceInt(
                                                        (_model.distanceMatrixResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!) /
                                                      1609.34) *
                                                  _model.rideTypeSelected!
                                                      .pricePerMile,
                                          timeFare:
                                              ((DistanceMatrixCall.durationInt(
                                                        (_model.distanceMatrixResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!) /
                                                      60) *
                                                  _model.rideTypeSelected!
                                                      .pricePerMinute,
                                          waitTimeAtPickupFare: 0.0,
                                          airportRide: true,
                                          whichAirport:
                                              _model.relevantAirport?.reference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'destination': [
                                              functions
                                                  .doublesToLatLong(
                                                      (currentUserDocument
                                                                  ?.favouriteLocations
                                                                  .toList() ??
                                                              [])
                                                          .where((e) =>
                                                              e.name ==
                                                              widget.name)
                                                          .toList()
                                                          .firstOrNull!
                                                          .lat,
                                                      (currentUserDocument
                                                                  ?.favouriteLocations
                                                                  .toList() ??
                                                              [])
                                                          .where((e) =>
                                                              e.name ==
                                                              widget.name)
                                                          .toList()
                                                          .firstOrNull!
                                                          .long)
                                                  .toGeoPoint()
                                            ],
                                            'destinationNames': [
                                              (currentUserDocument
                                                          ?.favouriteLocations
                                                          .toList() ??
                                                      [])
                                                  .where((e) =>
                                                      e.name == widget.name)
                                                  .toList()
                                                  .firstOrNull
                                                  ?.address
                                            ],
                                          },
                                        ),
                                      }, ridesRecordReference1);
                                      _shouldSetState = true;
                                      FFAppState().destinationReached = false;
                                      FFAppState().remainingDistance = 0.0;
                                      FFAppState().ridePlaced = true;
                                      FFAppState().tempRide =
                                          _model.rideCreatedAirPort?.reference;
                                      safeSetState(() {});

                                      await currentUserReference!.update({
                                        ...createUsersRecordData(
                                          rideGoingOn: _model
                                              .rideCreatedAirPort?.reference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'rideHistory':
                                                FieldValue.arrayUnion([
                                              _model
                                                  .rideCreatedAirPort?.reference
                                            ]),
                                          },
                                        ),
                                      });
                                      _model.driversGotAirPort =
                                          await queryDriversRecordOnce(
                                        queryBuilder: (driversRecord) =>
                                            driversRecord
                                                .where(
                                                  'vehicleTypesOffering',
                                                  arrayContains: _model
                                                      .rideTypeSelected
                                                      ?.reference,
                                                )
                                                .where(
                                                  'isOnline',
                                                  isEqualTo: true,
                                                )
                                                .where(
                                                  'waitingAtAirport',
                                                  isEqualTo: true,
                                                )
                                                .where(
                                                  'whichAirport',
                                                  isEqualTo: _model
                                                      .relevantAirport
                                                      ?.reference,
                                                ),
                                      );
                                      _shouldSetState = true;
                                      triggerPushNotification(
                                        notificationTitle: 'New Ride!',
                                        notificationText:
                                            'A new ride is available for you.',
                                        notificationSound: 'default',
                                        userRefs: _model.driversGotAirPort!
                                            .map((e) => e.userId)
                                            .withoutNulls
                                            .toList(),
                                        initialPageName: 'Home',
                                        parameterData: {},
                                      );

                                      context.goNamed(
                                        SearchingDriverWidget.routeName,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );

                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                  }

                                  var ridesRecordReference2 =
                                      RidesRecord.collection.doc();
                                  await ridesRecordReference2.set({
                                    ...createRidesRecordData(
                                      paid: false,
                                      startTime: getCurrentTimestamp,
                                      customer: currentUserReference,
                                      rideType:
                                          _model.rideTypeSelected?.reference,
                                      accepted: false,
                                      start: _model.pickUpGot?.latLngs,
                                      completedButNotPaid: false,
                                      started: false,
                                      canceled: false,
                                      startName: _model.pickUpGot?.title,
                                      basicFare:
                                          _model.rideTypeSelected?.basePrice,
                                      distanceFare:
                                          ((DistanceMatrixCall.distanceInt(
                                                    (_model.distanceMatrixResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!) /
                                                  1609.34) *
                                              _model.rideTypeSelected!
                                                  .pricePerMile,
                                      timeFare:
                                          ((DistanceMatrixCall.durationInt(
                                                    (_model.distanceMatrixResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!) /
                                                  60) *
                                              _model.rideTypeSelected!
                                                  .pricePerMinute,
                                      waitTimeAtPickupFare: 0.0,
                                      airportRide: false,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'destination': [
                                          functions
                                              .doublesToLatLong(
                                                  (currentUserDocument
                                                              ?.favouriteLocations
                                                              .toList() ??
                                                          [])
                                                      .where((e) =>
                                                          e.name ==
                                                          widget.name)
                                                      .toList()
                                                      .firstOrNull!
                                                      .lat,
                                                  (currentUserDocument
                                                              ?.favouriteLocations
                                                              .toList() ??
                                                          [])
                                                      .where((e) =>
                                                          e.name ==
                                                          widget.name)
                                                      .toList()
                                                      .firstOrNull!
                                                      .long)
                                              .toGeoPoint()
                                        ],
                                        'destinationNames': [
                                          (currentUserDocument
                                                      ?.favouriteLocations
                                                      .toList() ??
                                                  [])
                                              .where(
                                                  (e) => e.name == widget.name)
                                              .toList()
                                              .firstOrNull
                                              ?.address
                                        ],
                                      },
                                    ),
                                  });
                                  _model.rideCreated =
                                      RidesRecord.getDocumentFromData({
                                    ...createRidesRecordData(
                                      paid: false,
                                      startTime: getCurrentTimestamp,
                                      customer: currentUserReference,
                                      rideType:
                                          _model.rideTypeSelected?.reference,
                                      accepted: false,
                                      start: _model.pickUpGot?.latLngs,
                                      completedButNotPaid: false,
                                      started: false,
                                      canceled: false,
                                      startName: _model.pickUpGot?.title,
                                      basicFare:
                                          _model.rideTypeSelected?.basePrice,
                                      distanceFare:
                                          ((DistanceMatrixCall.distanceInt(
                                                    (_model.distanceMatrixResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!) /
                                                  1609.34) *
                                              _model.rideTypeSelected!
                                                  .pricePerMile,
                                      timeFare:
                                          ((DistanceMatrixCall.durationInt(
                                                    (_model.distanceMatrixResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!) /
                                                  60) *
                                              _model.rideTypeSelected!
                                                  .pricePerMinute,
                                      waitTimeAtPickupFare: 0.0,
                                      airportRide: false,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'destination': [
                                          functions
                                              .doublesToLatLong(
                                                  (currentUserDocument
                                                              ?.favouriteLocations
                                                              .toList() ??
                                                          [])
                                                      .where((e) =>
                                                          e.name ==
                                                          widget.name)
                                                      .toList()
                                                      .firstOrNull!
                                                      .lat,
                                                  (currentUserDocument
                                                              ?.favouriteLocations
                                                              .toList() ??
                                                          [])
                                                      .where((e) =>
                                                          e.name ==
                                                          widget.name)
                                                      .toList()
                                                      .firstOrNull!
                                                      .long)
                                              .toGeoPoint()
                                        ],
                                        'destinationNames': [
                                          (currentUserDocument
                                                      ?.favouriteLocations
                                                      .toList() ??
                                                  [])
                                              .where(
                                                  (e) => e.name == widget.name)
                                              .toList()
                                              .firstOrNull
                                              ?.address
                                        ],
                                      },
                                    ),
                                  }, ridesRecordReference2);
                                  _shouldSetState = true;
                                  FFAppState().destinationReached = false;
                                  FFAppState().remainingDistance = 0.0;
                                  FFAppState().ridePlaced = true;
                                  FFAppState().tempRide =
                                      _model.rideCreated?.reference;
                                  safeSetState(() {});

                                  await currentUserReference!.update({
                                    ...createUsersRecordData(
                                      rideGoingOn:
                                          _model.rideCreated?.reference,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'rideHistory': FieldValue.arrayUnion(
                                            [_model.rideCreated?.reference]),
                                      },
                                    ),
                                  });
                                  _model.driversGot =
                                      await queryDriversRecordOnce(
                                    queryBuilder: (driversRecord) =>
                                        driversRecord
                                            .where(
                                              'vehicleTypesOffering',
                                              arrayContains: _model
                                                  .rideTypeSelected?.reference,
                                            )
                                            .where(
                                              'isOnline',
                                              isEqualTo: true,
                                            )
                                            .where(
                                              'waitingAtAirport',
                                              isEqualTo: false,
                                            ),
                                  );
                                  _shouldSetState = true;
                                  triggerPushNotification(
                                    notificationTitle: 'New Ride!',
                                    notificationText:
                                        'A new ride is available for you.',
                                    notificationSound: 'default',
                                    userRefs: _model.driversGot!
                                        .map((e) => e.userId)
                                        .withoutNulls
                                        .toList(),
                                    initialPageName: 'Home',
                                    parameterData: {},
                                  );

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
                              }
                              if (_shouldSetState) safeSetState(() {});
                            },
                            text: 'Ride',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconAlignment: IconAlignment.end,
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                  ].divide(SizedBox(height: 10.0)),
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
