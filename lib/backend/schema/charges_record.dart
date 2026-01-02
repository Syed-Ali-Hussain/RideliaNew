import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChargesRecord extends FirestoreRecord {
  ChargesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "driverWaitingFee" field.
  double? _driverWaitingFee;
  double get driverWaitingFee => _driverWaitingFee ?? 0.0;
  bool hasDriverWaitingFee() => _driverWaitingFee != null;

  // "passengerWaitingFee" field.
  double? _passengerWaitingFee;
  double get passengerWaitingFee => _passengerWaitingFee ?? 0.0;
  bool hasPassengerWaitingFee() => _passengerWaitingFee != null;

  void _initializeFields() {
    _driverWaitingFee = castToType<double>(snapshotData['driverWaitingFee']);
    _passengerWaitingFee =
        castToType<double>(snapshotData['passengerWaitingFee']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('charges');

  static Stream<ChargesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChargesRecord.fromSnapshot(s));

  static Future<ChargesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChargesRecord.fromSnapshot(s));

  static ChargesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChargesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChargesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChargesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChargesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChargesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChargesRecordData({
  double? driverWaitingFee,
  double? passengerWaitingFee,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'driverWaitingFee': driverWaitingFee,
      'passengerWaitingFee': passengerWaitingFee,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChargesRecordDocumentEquality implements Equality<ChargesRecord> {
  const ChargesRecordDocumentEquality();

  @override
  bool equals(ChargesRecord? e1, ChargesRecord? e2) {
    return e1?.driverWaitingFee == e2?.driverWaitingFee &&
        e1?.passengerWaitingFee == e2?.passengerWaitingFee;
  }

  @override
  int hash(ChargesRecord? e) =>
      const ListEquality().hash([e?.driverWaitingFee, e?.passengerWaitingFee]);

  @override
  bool isValidKey(Object? o) => o is ChargesRecord;
}
