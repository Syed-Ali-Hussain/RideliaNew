import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RideTypesRecord extends FirestoreRecord {
  RideTypesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "carImage" field.
  String? _carImage;
  String get carImage => _carImage ?? '';
  bool hasCarImage() => _carImage != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  // "pricePerMile" field.
  double? _pricePerMile;
  double get pricePerMile => _pricePerMile ?? 0.0;
  bool hasPricePerMile() => _pricePerMile != null;

  // "basePrice" field.
  double? _basePrice;
  double get basePrice => _basePrice ?? 0.0;
  bool hasBasePrice() => _basePrice != null;

  // "pricePerMinute" field.
  double? _pricePerMinute;
  double get pricePerMinute => _pricePerMinute ?? 0.0;
  bool hasPricePerMinute() => _pricePerMinute != null;

  // "pricePerMinuteBeforePickup" field.
  double? _pricePerMinuteBeforePickup;
  double get pricePerMinuteBeforePickup => _pricePerMinuteBeforePickup ?? 0.0;
  bool hasPricePerMinuteBeforePickup() => _pricePerMinuteBeforePickup != null;

  // "driverShare" field.
  double? _driverShare;
  double get driverShare => _driverShare ?? 0.0;
  bool hasDriverShare() => _driverShare != null;

  void _initializeFields() {
    _carImage = snapshotData['carImage'] as String?;
    _name = snapshotData['name'] as String?;
    _owner = snapshotData['owner'] as DocumentReference?;
    _pricePerMile = castToType<double>(snapshotData['pricePerMile']);
    _basePrice = castToType<double>(snapshotData['basePrice']);
    _pricePerMinute = castToType<double>(snapshotData['pricePerMinute']);
    _pricePerMinuteBeforePickup =
        castToType<double>(snapshotData['pricePerMinuteBeforePickup']);
    _driverShare = castToType<double>(snapshotData['driverShare']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rideTypes');

  static Stream<RideTypesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RideTypesRecord.fromSnapshot(s));

  static Future<RideTypesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RideTypesRecord.fromSnapshot(s));

  static RideTypesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RideTypesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RideTypesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RideTypesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RideTypesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RideTypesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRideTypesRecordData({
  String? carImage,
  String? name,
  DocumentReference? owner,
  double? pricePerMile,
  double? basePrice,
  double? pricePerMinute,
  double? pricePerMinuteBeforePickup,
  double? driverShare,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'carImage': carImage,
      'name': name,
      'owner': owner,
      'pricePerMile': pricePerMile,
      'basePrice': basePrice,
      'pricePerMinute': pricePerMinute,
      'pricePerMinuteBeforePickup': pricePerMinuteBeforePickup,
      'driverShare': driverShare,
    }.withoutNulls,
  );

  return firestoreData;
}

class RideTypesRecordDocumentEquality implements Equality<RideTypesRecord> {
  const RideTypesRecordDocumentEquality();

  @override
  bool equals(RideTypesRecord? e1, RideTypesRecord? e2) {
    return e1?.carImage == e2?.carImage &&
        e1?.name == e2?.name &&
        e1?.owner == e2?.owner &&
        e1?.pricePerMile == e2?.pricePerMile &&
        e1?.basePrice == e2?.basePrice &&
        e1?.pricePerMinute == e2?.pricePerMinute &&
        e1?.pricePerMinuteBeforePickup == e2?.pricePerMinuteBeforePickup &&
        e1?.driverShare == e2?.driverShare;
  }

  @override
  int hash(RideTypesRecord? e) => const ListEquality().hash([
        e?.carImage,
        e?.name,
        e?.owner,
        e?.pricePerMile,
        e?.basePrice,
        e?.pricePerMinute,
        e?.pricePerMinuteBeforePickup,
        e?.driverShare
      ]);

  @override
  bool isValidKey(Object? o) => o is RideTypesRecord;
}
