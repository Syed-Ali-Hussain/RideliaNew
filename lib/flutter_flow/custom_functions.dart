import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<FavouriteLocationStruct> favLocations() {
  final List<String> names = [
    "Home",
    "Work",
    "School",
    "Market",
    "Food",
    "Gym"
  ];

  return names
      .map((name) => FavouriteLocationStruct(
            name: name,
            lat: null, // you can set this later when user saves it
            long: null,
            address: null, // also set later
          ))
      .toList();
}

String mapTheme(bool darkMode) {
  const darkMapTheme = '''[
  {
    "elementType": "geometry",
    "stylers": [{"color": "#0f161b"}]
  },
  {
    "elementType": "labels.icon",
    "stylers": [{"visibility": "off"}]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#aaaaaa"}]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [{"color": "#1d1d1d"}]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#ffffff"}]   
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#95a1ac"}]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [{"color": "#151A1D"}]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [{"color": "#151F11"}]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#6b9a76"}]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [{"color": "#1d2428"}]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#cccccc"}]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [{"color": "#4d4d4d"}]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#eeeeee"}]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [{"visibility": "off"}]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#999999"}]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [{"color": "#444444"}]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [{"color": "#262d34"}]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#2387C3"}]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [{"color": "#202d36"}]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#515c6d"}]
  }
]''';

  const lightMapTheme = '''[
    {
      "elementType": "geometry",
      "stylers": [{"color": "#f1f4f8"}]
    },
    {
      "elementType": "labels.icon",
      "stylers": [{"visibility": "off"}]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [{"color": "#f5f5f5"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#bdbdbd"}]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [{"color": "#d7dbe4"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [{"color": "#959b93"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#6b9a76"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [{"color": "#ffffff"}]
    },
    {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [{"color": "#dadada"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#9e9e9e"}]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [{"color": "#e5e5e5"}]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [{"color": "#eeeeee"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#c9c9c9"}]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#9e9e9e"}]
    }
  ]''';

  return darkMode ? darkMapTheme : lightMapTheme;
}

LatLng latLongForUpload(dynamic position) {
  return LatLng(
    position['lat'] as double,
    position['lng'] as double,
  );
}

List<FavouriteLocationStruct> favLocationUpdate(
  String elementNameToEdit,
  List<FavouriteLocationStruct>? oldList,
  FavouriteLocationStruct newElement,
) {
  if (oldList == null) return [];

  return oldList.map((item) {
    if (item.name == elementNameToEdit) {
      return newElement;
    } else {
      return item;
    }
  }).toList();
}

LatLng doublesToLatLong(
  double lat,
  double long,
) {
  return LatLng(lat, long);
}

double averageRating(List<RatingStruct>? allRatings) {
  if (allRatings == null || allRatings.isEmpty) return 0.0;

  double total = 0.0;
  for (var rating in allRatings) {
    total += rating.ratingGiven;
  }

  return total / allRatings.length;
}

double durationPrice(
  DateTime startTime,
  DateTime endTime,
  double rate,
) {
  double minutes = endTime.difference(startTime).inMinutes.toDouble();
  return minutes * rate;
}

double? applyAbsoluteDiscount(
  double basePrice,
  double discount,
) {
  double finalPrice = basePrice - discount;
  if (finalPrice < 0) {
    finalPrice = 0;
  }
  return finalPrice;
}

double applyPercentageDiscount(
  double percentageAmount,
  double basePrice,
) {
  double discount = (percentageAmount / 100) * basePrice;
  double finalPrice = basePrice - discount;
  return finalPrice;
}

double driverShareCalculator(
  double totalPrice,
  double sharePercentage,
) {
  if (totalPrice < 0 || sharePercentage < 0) {
    return 0;
  }
  return totalPrice * (sharePercentage / 100);
}

String locationForDistanceApi(LatLng inputLocation) {
  return '${inputLocation.latitude.toStringAsFixed(6)},${inputLocation.longitude.toStringAsFixed(6)}';
}

String placeDetailToDistanceMatrix(
  double latitude,
  double longitude,
) {
  return '$latitude,$longitude';
}

double distancePrice(
  List<double> distances,
  double ratePerMile,
) {
  double totalMeters = distances.fold(0.0, (sum, d) => sum + d);

  // Convert meters → miles (1 mile ≈ 1609.34 meters)
  double totalMiles = totalMeters / 1609.34;

  // Multiply by price per mile
  return totalMiles * ratePerMile;
}

String wayPointsForDistanceApi(List<LatLng> allPoints) {
  if (allPoints.length <= 1) return '';

  // Take all except the last element (destination)
  final waypoints = allPoints.sublist(0, allPoints.length - 1);

  // Join into "lat,lng|lat,lng|..."
  return waypoints
      .map((point) =>
          '${point.latitude.toStringAsFixed(6)},${point.longitude.toStringAsFixed(6)}')
      .join('|');
}

String? getFriendlyErrorMessage(String code) {
  switch (code) {
    case "invalid-verification-code":
      return "The code you entered is invalid. Please try again.";
    case "session-expired":
      return "The code has expired. Request a new one.";
    case "credential-already-in-use":
      return "This phone number is already linked to another account.";
    case "provider-already-linked":
      return "You have already linked a phone number.";
    case "requires-recent-login":
      return "Please log in again before linking your phone.";
    case "network-request-failed":
      return "Check your internet connection and try again.";
    case "no-current-user":
      return "You are not signed in.";
    default:
      return "Something went wrong. Please try again.";
  }
}

String waitlistNumber(
  List<WaitlistRecord> allPeople,
  DocumentReference ourDriverId,
) {
  for (int i = 0; i < allPeople.length; i++) {
    if (allPeople[i].driverId == ourDriverId) {
      // +1 because lists are 0-based but queue numbers are 1-based
      return (i + 1).toString();
    }
  }

  // If not found, return "-"
  return "-";
}

List<LatLng> arrangeLatlongs(
  LatLng origin,
  List<LatLng> dropoffs,
) {
  return [origin, ...dropoffs];
}

DateTime todayStart() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

DateTime todayEnd() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
}

double sumEarnings(List<RechargeHistoryRecord>? allRides) {
  if (allRides == null || allRides.isEmpty) return 0.0;

  double total = 0.0;
  for (final ride in allRides) {
    total += ride.amount;
  }
  return total;
}

String oldMapTheme(bool darkMode) {
  const darkMapTheme = '''[
    {
      "elementType": "geometry",
      "stylers": [{"color": "#0f161b"}]
    },
    {
      "elementType": "labels.icon",
      "stylers": [{"visibility": "off"}]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#aaaaaa"}]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [{"color": "#1d1d1d"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#666666"}]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [{"color": "#151A1D"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#888888"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [{"color": "#151F11"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#6b9a76"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [{"color": "#1d2428"}]
    },
    {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#cccccc"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [{"color": "#4d4d4d"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#eeeeee"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#999999"}]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [{"color": "#444444"}]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [{"color": "#3a3a3a"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#202d36"}]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#515c6d"}]
    }
  ]''';

  const lightMapTheme = '''[
    {
      "elementType": "geometry",
      "stylers": [{"color": "#f1f4f8"}]
    },
    {
      "elementType": "labels.icon",
      "stylers": [{"visibility": "off"}]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [{"color": "#f5f5f5"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#bdbdbd"}]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [{"color": "#d7dbe4"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [{"color": "#959b93"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#6b9a76"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [{"color": "#ffffff"}]
    },
    {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [{"color": "#dadada"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#9e9e9e"}]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [{"color": "#e5e5e5"}]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [{"color": "#eeeeee"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#c9c9c9"}]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#9e9e9e"}]
    }
  ]''';

  return darkMode ? darkMapTheme : lightMapTheme;
}

double estimatedTimePrice(
  List<double> timeDurations,
  double pricePerMin,
) {
  // Sum all durations (Google gives them in seconds)
  double totalSeconds = timeDurations.fold(0.0, (sum, d) => sum + d);

  // Convert seconds → minutes
  double totalMinutes = totalSeconds / 60.0;

  // Multiply by price per minute
  return totalMinutes * pricePerMin;
}

List<DocumentReference>? reverseList(List<DocumentReference>? oldList) {
  if (oldList == null) return null;
  return oldList.reversed.toList();
}

DateTime fortyMinsEarly(DateTime time) {
  return time.subtract(const Duration(minutes: 40));
}

bool timeDiffExists(
  DateTime time1,
  DateTime time2,
  double differenceNeeded,
) {
  final diffInMinutes = time2.difference(time1).inMinutes.abs();
  return diffInMinutes > differenceNeeded;
}

String? ffMapWidgetPageCode() {
/*

``````````````````````````````````home page:`````````````````````````````
style: Theme.of(context).brightness == Brightness.dark
    ? GoogleMapStyle.dark
    : GoogleMapStyle.silver,



`````````````````````````````````lib/backend/schema/util/schema_util.dart
last function only update from:
List<T>? getDataList<T>(dynamic value) =>
    value is! List ? null : value.map((e) => castToType<T>(e)!).toList();



update to:
List<T> getDataList<T>(dynamic value) {
  if (value == null || value is! List) return <T>[];

  return value
      .map((e) => castToType<T>(e))
      .whereType<T>()
      .toList();
}




``````````````````````````````````lib/flutter_flow/flutter_flow_google_map.dart```````````````````````
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'lat_lng.dart' as latlng;

export 'dart:async' show Completer;
export 'package:google_maps_flutter/google_maps_flutter.dart' hide LatLng;
export 'lat_lng.dart' show LatLng;

enum GoogleMapStyle {
  standard,
  silver,
  retro,
  dark,
  night,
  aubergine,
}

enum GoogleMarkerColor {
  red,
  orange,
  yellow,
  green,
  cyan,
  azure,
  blue,
  violet,
  magenta,
  rose,
}

@immutable
class MarkerImage {
  const MarkerImage({
    required this.imagePath,
    required this.isAssetImage,
    this.size = 20.0,
  });
  final String imagePath;
  final bool isAssetImage;
  final double size;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MarkerImage &&
          imagePath == other.imagePath &&
          isAssetImage == other.isAssetImage &&
          size == other.size);

  @override
  int get hashCode => Object.hash(imagePath, isAssetImage, size);
}

class FlutterFlowMarker {
  const FlutterFlowMarker(this.markerId, this.location, [this.onTap]);
  final String markerId;
  final latlng.LatLng location;
  final Future Function()? onTap;
}

class FlutterFlowGoogleMap extends StatefulWidget {
  const FlutterFlowGoogleMap({
    required this.controller,
    this.onCameraIdle,
    this.initialLocation,
    this.markers = const [],
    this.markerColor = GoogleMarkerColor.red,
    this.markerImage,
    this.mapType = MapType.normal,
    this.style = GoogleMapStyle.standard,
    this.initialZoom = 12,
    this.allowInteraction = true,
    this.allowZoom = true,
    this.showZoomControls = true,
    this.showLocation = true,
    this.showCompass = false,
    this.showMapToolbar = false,
    this.showTraffic = false,
    this.centerMapOnMarkerTap = false,
    // Whether the map takes gesture preference over the surrounding page.
    // This is useful when the map is inside a scrolling Widget, and you want
    // the gestures within the map to not affect the surrounding page.
    this.mapTakesGesturePreference = false,
    super.key,
  });

  final Completer<GoogleMapController> controller;
  final Function(latlng.LatLng)? onCameraIdle;
  final latlng.LatLng? initialLocation;
  final Iterable<FlutterFlowMarker> markers;
  final GoogleMarkerColor markerColor;
  final MarkerImage? markerImage;
  final MapType mapType;
  final GoogleMapStyle style;
  final double initialZoom;
  final bool allowInteraction;
  final bool allowZoom;
  final bool showZoomControls;
  final bool showLocation;
  final bool showCompass;
  final bool showMapToolbar;
  final bool showTraffic;
  final bool centerMapOnMarkerTap;
  final bool mapTakesGesturePreference;

  @override
  State<StatefulWidget> createState() => _FlutterFlowGoogleMapState();
}

class _FlutterFlowGoogleMapState extends State<FlutterFlowGoogleMap> {
  double get initialZoom => max(double.minPositive, widget.initialZoom);
  LatLng get initialPosition =>
      widget.initialLocation?.toGoogleMaps() ?? const LatLng(0.0, 0.0);

  late Completer<GoogleMapController> _controller;
  BitmapDescriptor? _markerDescriptor;
  late LatLng currentMapCenter;

  void initializeMarkerBitmap() {
    final markerImage = widget.markerImage;

    if (markerImage == null) {
      _markerDescriptor = BitmapDescriptor.defaultMarkerWithHue(
        googleMarkerColorMap[widget.markerColor]!,
      );
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final markerImageSize = Size.square(markerImage.size);
      var imageProvider = markerImage.isAssetImage
          ? Image.asset(markerImage.imagePath).image
          : CachedNetworkImageProvider(markerImage.imagePath);
      if (!kIsWeb) {
        // workaround for https://github.com/flutter/flutter/issues/34657 to
        // enable marker resizing on Android and iOS.
        final targetHeight =
            (markerImage.size * MediaQuery.of(context).devicePixelRatio)
                .toInt();
        imageProvider = ResizeImage(
          imageProvider,
          height: targetHeight,
          policy: ResizeImagePolicy.fit,
          allowUpscaling: true,
        );
      }
      final imageConfiguration =
          createLocalImageConfiguration(context, size: markerImageSize);
      imageProvider
          .resolve(imageConfiguration)
          .addListener(ImageStreamListener((img, _) async {
        final bytes = await img.image.toByteData(format: ImageByteFormat.png);
        if (bytes != null && mounted) {
          _markerDescriptor = BitmapDescriptor.fromBytes(
            bytes.buffer.asUint8List(),
            size: markerImageSize,
          );
          setState(() {});
        }
      }));
    });
  }

  void onCameraIdle() => widget.onCameraIdle?.call(currentMapCenter.toLatLng());

  @override
  void initState() {
    super.initState();
    currentMapCenter = initialPosition;
    _controller = widget.controller;
    initializeMarkerBitmap();
  }

  @override
  void didUpdateWidget(FlutterFlowGoogleMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Rebuild the marker bitmap if the marker image changes.
    if (widget.markerImage != oldWidget.markerImage) {
      initializeMarkerBitmap();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapHasGesturePreference = widget.mapTakesGesturePreference &&
        widget.allowInteraction &&
        widget.allowZoom;

    final googleMapWidget = AbsorbPointer(
      absorbing: !widget.allowInteraction,
      child: GoogleMap(
        onMapCreated: (controller) async {
          _controller.complete(controller);
          await controller.setMapStyle(googleMapStyleStrings[widget.style]);
        },
        onCameraIdle: onCameraIdle,
        onCameraMove: (position) => currentMapCenter = position.target,
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: initialZoom,
        ),
        mapType: widget.mapType,
        zoomGesturesEnabled: widget.allowZoom,
        zoomControlsEnabled: widget.showZoomControls,
        myLocationEnabled: widget.showLocation,
        myLocationButtonEnabled: false,
        compassEnabled: widget.showCompass,
        mapToolbarEnabled: widget.showMapToolbar,
        trafficEnabled: widget.showTraffic,
        markers: widget.markers
            .map(
              (m) => Marker(
                markerId: MarkerId(m.markerId),
                position: m.location.toGoogleMaps(),
                icon: _markerDescriptor ?? BitmapDescriptor.defaultMarker,
                onTap: () async {
                  if (widget.centerMapOnMarkerTap) {
                    final controller = await _controller.future;
                    await controller.animateCamera(
                      CameraUpdate.newLatLng(m.location.toGoogleMaps()),
                    );
                    currentMapCenter = m.location.toGoogleMaps();
                    onCameraIdle();
                  }
                  await m.onTap?.call();
                },
              ),
            )
            .toSet(),
        gestureRecognizers: {
          if (mapHasGesturePreference)
            const Factory<OneSequenceGestureRecognizer>(
              EagerGestureRecognizer.new,
            ),
        },
        webGestureHandling:
            mapHasGesturePreference ? WebGestureHandling.cooperative : null,
      ),
    );

    return mapHasGesturePreference
        ? GestureDetector(
            onVerticalDragStart: (_) {},
            behavior: HitTestBehavior.opaque,
            child: googleMapWidget,
          )
        : googleMapWidget;
  }
}

extension ToGoogleMapsLatLng on latlng.LatLng {
  LatLng toGoogleMaps() => LatLng(latitude, longitude);
}

extension GoogleMapsToLatLng on LatLng {
  latlng.LatLng toLatLng() => latlng.LatLng(latitude, longitude);
}

Map<GoogleMapStyle, String> googleMapStyleStrings = {
  GoogleMapStyle.standard: '[]',
  GoogleMapStyle.silver:
      r'''[
    {
      "elementType": "geometry",
      "stylers": [{"color": "#f1f4f8"}]
    },
    {
      "elementType": "labels.icon",
      "stylers": [{"visibility": "off"}]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [{"color": "#f5f5f5"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#bdbdbd"}]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [{"color": "#d7dbe4"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [{"color": "#959b93"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#6b9a76"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [{"color": "#ffffff"}]
    },
    {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [{"color": "#dadada"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels",
      "stylers": [{"visibility": "off"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#9e9e9e"}]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [{"color": "#e5e5e5"}]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [{"color": "#eeeeee"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#c9c9c9"}]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#9e9e9e"}]
    }
  ]''',
  GoogleMapStyle.retro:
      r'[{"elementType":"geometry","stylers":[{"color":"#ebe3cd"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#523735"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f1e6"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#c9b2a6"}]},{"featureType":"administrative.land_parcel","elementType":"geometry.stroke","stylers":[{"color":"#dcd2be"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#ae9e90"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#93817c"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#a5b076"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#447530"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#f5f1e6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#fdfcf8"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f8c967"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#e9bc62"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#e98d58"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.stroke","stylers":[{"color":"#db8555"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#806b63"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"transit.line","elementType":"labels.text.fill","stylers":[{"color":"#8f7d77"}]},{"featureType":"transit.line","elementType":"labels.text.stroke","stylers":[{"color":"#ebe3cd"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#b9d3c2"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#92998d"}]}]',
  GoogleMapStyle.dark:
      r'''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#0d161d"
      }
    ]
  },
  {
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f282c"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#7f8d8f"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#15220f"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#20282d"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels",
    "stylers": [
      {
        "color": "#7f8f94"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#20282d"
      },
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "transit.station.airport",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#8592a6"
      },
      {
        "weight": 2
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#001b2f"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''',
  GoogleMapStyle.night:
      r'[{"elementType":"geometry","stylers":[{"color":"#242f3e"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#746855"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#242f3e"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#263c3f"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#6b9a76"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#38414e"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#212a37"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#9ca5b3"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#746855"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#1f2835"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#f3d19c"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#2f3948"}]},{"featureType":"transit.station","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#17263c"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#515c6d"}]},{"featureType":"water","elementType":"labels.text.stroke","stylers":[{"color":"#17263c"}]}]',
  GoogleMapStyle.aubergine:
      r'[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#64779e"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"landscape.man_made","elementType":"geometry.stroke","stylers":[{"color":"#334e87"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#023e58"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#283d6a"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#6f9ba5"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#023e58"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#3C7680"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"road","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#2c6675"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#255763"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#b0d5ce"}]},{"featureType":"road.highway","elementType":"labels.text.stroke","stylers":[{"color":"#023e58"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"transit","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"transit.line","elementType":"geometry.fill","stylers":[{"color":"#283d6a"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#3a4762"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#4e6d70"}]}]',
};

Map<GoogleMarkerColor, double> googleMarkerColorMap = {
  GoogleMarkerColor.red: 0.0,
  GoogleMarkerColor.orange: 30.0,
  GoogleMarkerColor.yellow: 60.0,
  GoogleMarkerColor.green: 120.0,
  GoogleMarkerColor.cyan: 180.0,
  GoogleMarkerColor.azure: 210.0,
  GoogleMarkerColor.blue: 240.0,
  GoogleMarkerColor.violet: 270.0,
  GoogleMarkerColor.magenta: 300.0,
  GoogleMarkerColor.rose: 330.0,
};

*/
}
