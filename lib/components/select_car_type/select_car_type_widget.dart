import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'select_car_type_model.dart';
export 'select_car_type_model.dart';

class SelectCarTypeWidget extends StatefulWidget {
  const SelectCarTypeWidget({
    super.key,
    required this.element,
    required this.distance,
    required this.duration,
  });

  final RideTypesRecord? element;
  final List<double>? distance;
  final List<double>? duration;

  @override
  State<SelectCarTypeWidget> createState() => _SelectCarTypeWidgetState();
}

class _SelectCarTypeWidgetState extends State<SelectCarTypeWidget> {
  late SelectCarTypeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectCarTypeModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.rawPrice = widget.element!.basePrice +
          functions.distancePrice(
              widget.distance!.toList(), widget.element!.pricePerMile) +
          functions.estimatedTimePrice(
              widget.duration!.toList(), widget.element!.pricePerMinute);
      safeSetState(() {});
      if (FFAppState().promoCodeUsed != null) {
        _model.promoGot =
            await PromoCodesRecord.getDocumentOnce(FFAppState().promoCodeUsed!);
        if (_model.promoGot?.absoluteDiscount != null) {
          _model.discountedValue = functions.applyAbsoluteDiscount(
              _model.rawPrice!, _model.promoGot!.absoluteDiscount);
          safeSetState(() {});
        } else {
          _model.discountedValue = functions.applyPercentageDiscount(
              _model.promoGot!.percentageDiscount, _model.rawPrice!);
          safeSetState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 500),
            fadeOutDuration: Duration(milliseconds: 500),
            imageUrl: widget.element!.carImage,
            width: 80.0,
            height: 60.0,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Text(
            valueOrDefault<String>(
              widget.element?.name,
              'connectivity error',
            ),
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_model.discountedValue != null)
              Text(
                valueOrDefault<String>(
                  formatNumber(
                    _model.rawPrice,
                    formatType: FormatType.custom,
                    format: '###,##0.00',
                    locale: '',
                  ),
                  '0',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).error,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            if (_model.discountedValue != null)
              Text(
                formatNumber(
                  _model.discountedValue,
                  formatType: FormatType.custom,
                  currency: '\$',
                  format: '###,##0.00',
                  locale: '',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            if (_model.discountedValue == null)
              Text(
                formatNumber(
                  _model.rawPrice,
                  formatType: FormatType.custom,
                  currency: '\$',
                  format: '###,##0.00',
                  locale: '',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
          ],
        ),
      ].divide(SizedBox(width: 10.0)).addToEnd(SizedBox(width: 10.0)),
    );
  }
}
