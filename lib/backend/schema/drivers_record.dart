import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DriversRecord extends FirestoreRecord {
  DriversRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "isOnline" field.
  bool? _isOnline;
  bool get isOnline => _isOnline ?? false;
  bool hasIsOnline() => _isOnline != null;

  // "numberPlate" field.
  String? _numberPlate;
  String get numberPlate => _numberPlate ?? '';
  bool hasNumberPlate() => _numberPlate != null;

  // "carModel" field.
  String? _carModel;
  String get carModel => _carModel ?? '';
  bool hasCarModel() => _carModel != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "vehicleTypesOffering" field.
  List<DocumentReference>? _vehicleTypesOffering;
  List<DocumentReference> get vehicleTypesOffering =>
      _vehicleTypesOffering ?? const [];
  bool hasVehicleTypesOffering() => _vehicleTypesOffering != null;

  // "waitingAtAirport" field.
  bool? _waitingAtAirport;
  bool get waitingAtAirport => _waitingAtAirport ?? false;
  bool hasWaitingAtAirport() => _waitingAtAirport != null;

  // "whichAirport" field.
  DocumentReference? _whichAirport;
  DocumentReference? get whichAirport => _whichAirport;
  bool hasWhichAirport() => _whichAirport != null;

  // "allowedRideTypes" field.
  List<DocumentReference>? _allowedRideTypes;
  List<DocumentReference> get allowedRideTypes => _allowedRideTypes ?? const [];
  bool hasAllowedRideTypes() => _allowedRideTypes != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as DocumentReference?;
    _isOnline = snapshotData['isOnline'] as bool?;
    _numberPlate = snapshotData['numberPlate'] as String?;
    _carModel = snapshotData['carModel'] as String?;
    _image = snapshotData['image'] as String?;
    _vehicleTypesOffering = getDataList(snapshotData['vehicleTypesOffering']);
    _waitingAtAirport = snapshotData['waitingAtAirport'] as bool?;
    _whichAirport = snapshotData['whichAirport'] as DocumentReference?;
    _allowedRideTypes = getDataList(snapshotData['allowedRideTypes']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drivers');

  static Stream<DriversRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DriversRecord.fromSnapshot(s));

  static Future<DriversRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DriversRecord.fromSnapshot(s));

  static DriversRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DriversRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DriversRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DriversRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DriversRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DriversRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDriversRecordData({
  DocumentReference? userId,
  bool? isOnline,
  String? numberPlate,
  String? carModel,
  String? image,
  bool? waitingAtAirport,
  DocumentReference? whichAirport,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'isOnline': isOnline,
      'numberPlate': numberPlate,
      'carModel': carModel,
      'image': image,
      'waitingAtAirport': waitingAtAirport,
      'whichAirport': whichAirport,
    }.withoutNulls,
  );

  return firestoreData;
}

class DriversRecordDocumentEquality implements Equality<DriversRecord> {
  const DriversRecordDocumentEquality();

  @override
  bool equals(DriversRecord? e1, DriversRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userId == e2?.userId &&
        e1?.isOnline == e2?.isOnline &&
        e1?.numberPlate == e2?.numberPlate &&
        e1?.carModel == e2?.carModel &&
        e1?.image == e2?.image &&
        listEquality.equals(
            e1?.vehicleTypesOffering, e2?.vehicleTypesOffering) &&
        e1?.waitingAtAirport == e2?.waitingAtAirport &&
        e1?.whichAirport == e2?.whichAirport &&
        listEquality.equals(e1?.allowedRideTypes, e2?.allowedRideTypes);
  }

  @override
  int hash(DriversRecord? e) => const ListEquality().hash([
        e?.userId,
        e?.isOnline,
        e?.numberPlate,
        e?.carModel,
        e?.image,
        e?.vehicleTypesOffering,
        e?.waitingAtAirport,
        e?.whichAirport,
        e?.allowedRideTypes
      ]);

  @override
  bool isValidKey(Object? o) => o is DriversRecord;
}
