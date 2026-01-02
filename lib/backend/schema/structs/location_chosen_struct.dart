// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LocationChosenStruct extends FFFirebaseStruct {
  LocationChosenStruct({
    LatLng? latLngs,
    String? title,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _latLngs = latLngs,
        _title = title,
        super(firestoreUtilData);

  // "latLngs" field.
  LatLng? _latLngs;
  LatLng? get latLngs => _latLngs;
  set latLngs(LatLng? val) => _latLngs = val;

  bool hasLatLngs() => _latLngs != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  static LocationChosenStruct fromMap(Map<String, dynamic> data) =>
      LocationChosenStruct(
        latLngs: data['latLngs'] as LatLng?,
        title: data['title'] as String?,
      );

  static LocationChosenStruct? maybeFromMap(dynamic data) => data is Map
      ? LocationChosenStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'latLngs': _latLngs,
        'title': _title,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'latLngs': serializeParam(
          _latLngs,
          ParamType.LatLng,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
      }.withoutNulls;

  static LocationChosenStruct fromSerializableMap(Map<String, dynamic> data) =>
      LocationChosenStruct(
        latLngs: deserializeParam(
          data['latLngs'],
          ParamType.LatLng,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LocationChosenStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LocationChosenStruct &&
        latLngs == other.latLngs &&
        title == other.title;
  }

  @override
  int get hashCode => const ListEquality().hash([latLngs, title]);
}

LocationChosenStruct createLocationChosenStruct({
  LatLng? latLngs,
  String? title,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LocationChosenStruct(
      latLngs: latLngs,
      title: title,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LocationChosenStruct? updateLocationChosenStruct(
  LocationChosenStruct? locationChosen, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    locationChosen
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLocationChosenStructData(
  Map<String, dynamic> firestoreData,
  LocationChosenStruct? locationChosen,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (locationChosen == null) {
    return;
  }
  if (locationChosen.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && locationChosen.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final locationChosenData =
      getLocationChosenFirestoreData(locationChosen, forFieldValue);
  final nestedData =
      locationChosenData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = locationChosen.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLocationChosenFirestoreData(
  LocationChosenStruct? locationChosen, [
  bool forFieldValue = false,
]) {
  if (locationChosen == null) {
    return {};
  }
  final firestoreData = mapToFirestore(locationChosen.toMap());

  // Add any Firestore field values
  locationChosen.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLocationChosenListFirestoreData(
  List<LocationChosenStruct>? locationChosens,
) =>
    locationChosens
        ?.map((e) => getLocationChosenFirestoreData(e, true))
        .toList() ??
    [];
