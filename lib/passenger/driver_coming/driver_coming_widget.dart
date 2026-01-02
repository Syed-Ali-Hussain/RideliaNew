import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/driver_details/driver_details_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'driver_coming_model.dart';
export 'driver_coming_model.dart';

class DriverComingWidget extends StatefulWidget {
  const DriverComingWidget({super.key});

  static String routeName = 'driverComing';
  static String routePath = '/driverComing';

  @override
  State<DriverComingWidget> createState() => _DriverComingWidgetState();
}

class _DriverComingWidgetState extends State<DriverComingWidget> {
  late DriverComingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DriverComingModel());
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
          ..listen((driverComingRidesRecord) async {
            if (_model.driverComingPreviousSnapshot != null &&
                !RidesRecordDocumentEquality().equals(driverComingRidesRecord,
                    _model.driverComingPreviousSnapshot)) {
              _model.rideDoc = await RidesRecord.getDocumentOnce(
                  currentUserDocument!.rideGoingOn!);
              if (_model.rideDoc!.canceled) {
                context.goNamed(HomeWidget.routeName);
              }
              if (_model.rideDoc!.started) {
                context.goNamed(
                  TravelStartWidget.routeName,
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                    ),
                  },
                );
              }

              safeSetState(() {});
            }
            _model.driverComingPreviousSnapshot = driverComingRidesRecord;
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

          final driverComingRidesRecord = snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: custom_widgets.FirebasePolylineMap(
                        width: double.infinity,
                        height: double.infinity,
                        googleApiKey: FFAppConstants.mapApiKey,
                        polylineColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        polylineWidth: 4,
                        deviationThreshold: 40.0,
                        arrivalThreshold: 40.0,
                        customMapStyle: functions.mapTheme(
                            Theme.of(context).brightness == Brightness.dark),
                        darkMode:
                            Theme.of(context).brightness == Brightness.dark,
                        driverDocumentRef: driverComingRidesRecord.driver!,
                        destination: driverComingRidesRecord.start!,
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Driver is\n',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            font: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 25.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    TextSpan(
                                      text: driverComingRidesRecord
                                                  .driverArriveTime !=
                                              null
                                          ? 'here to pick you!'
                                          : 'on his way!',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        font: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 25.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              FutureBuilder<List<DriversRecord>>(
                                future: queryDriversRecordOnce(
                                  queryBuilder: (driversRecord) =>
                                      driversRecord.where(
                                    'userId',
                                    isEqualTo: driverComingRidesRecord.driver,
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
                                          color: FlutterFlowTheme.of(context)
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
                                          ? iconButtonDriversRecordList.first
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
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: DriverDetailsWidget(
                                                driver:
                                                    iconButtonDriversRecord!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                  );
                                },
                              ),
                            ],
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
