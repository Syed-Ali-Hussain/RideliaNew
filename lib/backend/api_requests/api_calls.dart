import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class DistanceMatrixCall {
  static Future<ApiCallResponse> call({
    String? originLocation = '',
    String? destinationLocation = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Distance Matrix',
      apiUrl: 'https://maps.googleapis.com/maps/api/distancematrix/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'origins': originLocation,
        'destinations': destinationLocation,
        'key': "AIzaSyBXX6UowQpd1qCxdwlc24-xTCQ_S-XFPPA",
        'mode': "driving",
        'units': "imperial",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? distance(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.rows[:].elements[:].distance.text''',
      ));
  static String? duration(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.rows[:].elements[:].duration.text''',
      ));
  static List<String>? destinationAddress(dynamic response) => (getJsonField(
        response,
        r'''$.destination_addresses''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? originAddress(dynamic response) => (getJsonField(
        response,
        r'''$.origin_addresses''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static double? distanceInt(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.rows[:].elements[:].distance.value''',
      ));
  static double? durationInt(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.rows[:].elements[:].duration.value''',
      ));
}

class PlacesAutocompleteCall {
  static Future<ApiCallResponse> call({
    String? searched = '',
    String? userLocation = '',
    String? sessionToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Places Autocomplete',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'input': searched,
        'key': "AIzaSyBXX6UowQpd1qCxdwlc24-xTCQ_S-XFPPA",
        'location': userLocation,
        'language': "en",
        'sessiontoken': sessionToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? mainText(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].structured_formatting.main_text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? secondaryText(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].structured_formatting.secondary_text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? placeId(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].place_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? predictions(dynamic response) => getJsonField(
        response,
        r'''$.predictions''',
        true,
      ) as List?;
}

class PlaceDetailsCall {
  static Future<ApiCallResponse> call({
    String? placeId = '',
    String? sessionToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Place Details',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/details/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'place_id': placeId,
        'key': "AIzaSyBXX6UowQpd1qCxdwlc24-xTCQ_S-XFPPA",
        'sessiontoken': sessionToken,
        'fields': "geometry/location,name,icon,icon_background_color",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic location(dynamic response) => getJsonField(
        response,
        r'''$.result.geometry.location''',
      );
  static String? icon(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result.icon''',
      ));
  static String? iconBgColor(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.result.icon_background_color''',
      ));
  static double? locationLat(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.result.geometry.location.lat''',
      ));
  static double? locationLong(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.result.geometry.location.lng''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result.name''',
      ));
  static String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class DistanceWithWayPointsCall {
  static Future<ApiCallResponse> call({
    String? start = '',
    String? destination = '',
    String? wayPoints = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Distance with WayPoints',
      apiUrl: 'https://maps.googleapis.com/maps/api/directions/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'origin': start,
        'destination': destination,
        'waypoints': wayPoints,
        'key': "AIzaSyBXX6UowQpd1qCxdwlc24-xTCQ_S-XFPPA",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? distancesText(dynamic response) => (getJsonField(
        response,
        r'''$.routes[:].legs[:].distance.text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? durationsText(dynamic response) => (getJsonField(
        response,
        r'''$.routes[:].legs[:].duration.text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? distancesValues(dynamic response) => (getJsonField(
        response,
        r'''$.routes[:].legs[:].distance.value''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? durationsValues(dynamic response) => (getJsonField(
        response,
        r'''$.routes[:].legs[:].duration.value''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
}

class AirportsCall {
  static Future<ApiCallResponse> call({
    String? userLocation = '',
    String? sessionToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Airports',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'location': userLocation,
        'radius': "50000",
        'type': "airport",
        'key': "AIzaSyBXX6UowQpd1qCxdwlc24-xTCQ_S-XFPPA",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? locationJson(dynamic response) => getJsonField(
        response,
        r'''$.results[:].geometry.location''',
        true,
      ) as List?;
  static List<double>? locationLat(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].geometry.location.lat''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? locationLong(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].geometry.location.lng''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? placeId(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].place_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      ) as List?;
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
