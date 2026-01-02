import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RechargeHistoryRecord extends FirestoreRecord {
  RechargeHistoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "rideRef" field.
  DocumentReference? _rideRef;
  DocumentReference? get rideRef => _rideRef;
  bool hasRideRef() => _rideRef != null;

  // "details" field.
  String? _details;
  String get details => _details ?? '';
  bool hasDetails() => _details != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _amount = castToType<double>(snapshotData['amount']);
    _rideRef = snapshotData['rideRef'] as DocumentReference?;
    _details = snapshotData['details'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('rechargeHistory')
          : FirebaseFirestore.instance.collectionGroup('rechargeHistory');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('rechargeHistory').doc(id);

  static Stream<RechargeHistoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RechargeHistoryRecord.fromSnapshot(s));

  static Future<RechargeHistoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RechargeHistoryRecord.fromSnapshot(s));

  static RechargeHistoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RechargeHistoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RechargeHistoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RechargeHistoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RechargeHistoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RechargeHistoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRechargeHistoryRecordData({
  DateTime? date,
  double? amount,
  DocumentReference? rideRef,
  String? details,
  DocumentReference? user,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'amount': amount,
      'rideRef': rideRef,
      'details': details,
      'user': user,
    }.withoutNulls,
  );

  return firestoreData;
}

class RechargeHistoryRecordDocumentEquality
    implements Equality<RechargeHistoryRecord> {
  const RechargeHistoryRecordDocumentEquality();

  @override
  bool equals(RechargeHistoryRecord? e1, RechargeHistoryRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.amount == e2?.amount &&
        e1?.rideRef == e2?.rideRef &&
        e1?.details == e2?.details &&
        e1?.user == e2?.user;
  }

  @override
  int hash(RechargeHistoryRecord? e) => const ListEquality()
      .hash([e?.date, e?.amount, e?.rideRef, e?.details, e?.user]);

  @override
  bool isValidKey(Object? o) => o is RechargeHistoryRecord;
}
