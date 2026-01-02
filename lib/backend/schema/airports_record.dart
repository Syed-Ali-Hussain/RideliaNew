import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AirportsRecord extends FirestoreRecord {
  AirportsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "placeId" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  bool hasPlaceId() => _placeId != null;

  // "airportCode" field.
  String? _airportCode;
  String get airportCode => _airportCode ?? '';
  bool hasAirportCode() => _airportCode != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _placeId = snapshotData['placeId'] as String?;
    _airportCode = snapshotData['airportCode'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('airports');

  static Stream<AirportsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AirportsRecord.fromSnapshot(s));

  static Future<AirportsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AirportsRecord.fromSnapshot(s));

  static AirportsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AirportsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AirportsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AirportsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AirportsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AirportsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAirportsRecordData({
  String? name,
  LatLng? location,
  String? placeId,
  String? airportCode,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'location': location,
      'placeId': placeId,
      'airportCode': airportCode,
    }.withoutNulls,
  );

  return firestoreData;
}

class AirportsRecordDocumentEquality implements Equality<AirportsRecord> {
  const AirportsRecordDocumentEquality();

  @override
  bool equals(AirportsRecord? e1, AirportsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.location == e2?.location &&
        e1?.placeId == e2?.placeId &&
        e1?.airportCode == e2?.airportCode;
  }

  @override
  int hash(AirportsRecord? e) => const ListEquality()
      .hash([e?.name, e?.location, e?.placeId, e?.airportCode]);

  @override
  bool isValidKey(Object? o) => o is AirportsRecord;
}
