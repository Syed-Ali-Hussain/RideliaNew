import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ride_preview_driver_model.dart';
export 'ride_preview_driver_model.dart';

class RidePreviewDriverWidget extends StatefulWidget {
  const RidePreviewDriverWidget({super.key});

  static String routeName = 'ridePreviewDriver';
  static String routePath = '/ridePreviewDriver';

  @override
  State<RidePreviewDriverWidget> createState() =>
      _RidePreviewDriverWidgetState();
}

class _RidePreviewDriverWidgetState extends State<RidePreviewDriverWidget> {
  late RidePreviewDriverModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RidePreviewDriverModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<RidesRecord>(
        stream: RidesRecord.getDocument(currentUserDocument!.reservedRide!),
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

          final ridePreviewDriverRidesRecord = snapshot.data!;

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
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 25.0,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
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
                            polylineColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            latlongs: functions.arrangeLatlongs(
                                ridePreviewDriverRidesRecord.start!,
                                ridePreviewDriverRidesRecord.destination
                                    .toList()),
                            mapThemeString: functions.mapTheme(
                                Theme.of(context).brightness ==
                                    Brightness.dark),
                          ),
                        ),
                      ),
                    ),
                    if (valueOrDefault<bool>(
                        currentUserDocument?.driver, false))
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            FFAppState().ridePlaced = true;
                            safeSetState(() {});

                            await currentUserDocument!.reservedRide!
                                .update(createRidesRecordData(
                              driverComingToPickReservation: true,
                            ));
                            triggerPushNotification(
                              notificationTitle: 'Your driver is on his way!',
                              notificationText:
                                  'Your driver is coming to pick you up.',
                              notificationSound: 'default',
                              userRefs: [
                                ridePreviewDriverRidesRecord.customer!
                              ],
                              initialPageName: 'Home',
                              parameterData: {},
                            );

                            context.goNamed(
                              PickPassengerWidget.routeName,
                              queryParameters: {
                                'startPoint': serializeParam(
                                  ridePreviewDriverRidesRecord.start,
                                  ParamType.LatLng,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                ),
                              },
                            );
                          },
                          text: 'Start Ride',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
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
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                  ].divide(SizedBox(height: 10.0)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
