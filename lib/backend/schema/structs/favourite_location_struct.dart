// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FavouriteLocationStruct extends FFFirebaseStruct {
  FavouriteLocationStruct({
    String? name,
    double? lat,
    double? long,
    String? address,
    String? placeId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _lat = lat,
        _long = long,
        _address = address,
        _placeId = placeId,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "lat" field.
  double? _lat;
  double get lat => _lat ?? 0.0;
  set lat(double? val) => _lat = val;

  void incrementLat(double amount) => lat = lat + amount;

  bool hasLat() => _lat != null;

  // "long" field.
  double? _long;
  double get long => _long ?? 0.0;
  set long(double? val) => _long = val;

  void incrementLong(double amount) => long = long + amount;

  bool hasLong() => _long != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "placeId" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  set placeId(String? val) => _placeId = val;

  bool hasPlaceId() => _placeId != null;

  static FavouriteLocationStruct fromMap(Map<String, dynamic> data) =>
      FavouriteLocationStruct(
        name: data['name'] as String?,
        lat: castToType<double>(data['lat']),
        long: castToType<double>(data['long']),
        address: data['address'] as String?,
        placeId: data['placeId'] as String?,
      );

  static FavouriteLocationStruct? maybeFromMap(dynamic data) => data is Map
      ? FavouriteLocationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'lat': _lat,
        'long': _long,
        'address': _address,
        'placeId': _placeId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'lat': serializeParam(
          _lat,
          ParamType.double,
        ),
        'long': serializeParam(
          _long,
          ParamType.double,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
        'placeId': serializeParam(
          _placeId,
          ParamType.String,
        ),
      }.withoutNulls;

  static FavouriteLocationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      FavouriteLocationStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        lat: deserializeParam(
          data['lat'],
          ParamType.double,
          false,
        ),
        long: deserializeParam(
          data['long'],
          ParamType.double,
          false,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
        placeId: deserializeParam(
          data['placeId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FavouriteLocationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FavouriteLocationStruct &&
        name == other.name &&
        lat == other.lat &&
        long == other.long &&
        address == other.address &&
        placeId == other.placeId;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, lat, long, address, placeId]);
}

FavouriteLocationStruct createFavouriteLocationStruct({
  String? name,
  double? lat,
  double? long,
  String? address,
  String? placeId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FavouriteLocationStruct(
      name: name,
      lat: lat,
      long: long,
      address: address,
      placeId: placeId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FavouriteLocationStruct? updateFavouriteLocationStruct(
  FavouriteLocationStruct? favouriteLocation, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    favouriteLocation
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFavouriteLocationStructData(
  Map<String, dynamic> firestoreData,
  FavouriteLocationStruct? favouriteLocation,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (favouriteLocation == null) {
    return;
  }
  if (favouriteLocation.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && favouriteLocation.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final favouriteLocationData =
      getFavouriteLocationFirestoreData(favouriteLocation, forFieldValue);
  final nestedData =
      favouriteLocationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = favouriteLocation.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFavouriteLocationFirestoreData(
  FavouriteLocationStruct? favouriteLocation, [
  bool forFieldValue = false,
]) {
  if (favouriteLocation == null) {
    return {};
  }
  final firestoreData = mapToFirestore(favouriteLocation.toMap());

  // Add any Firestore field values
  favouriteLocation.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFavouriteLocationListFirestoreData(
  List<FavouriteLocationStruct>? favouriteLocations,
) =>
    favouriteLocations
        ?.map((e) => getFavouriteLocationFirestoreData(e, true))
        .toList() ??
    [];
