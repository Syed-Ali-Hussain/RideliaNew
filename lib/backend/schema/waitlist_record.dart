import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WaitlistRecord extends FirestoreRecord {
  WaitlistRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "driverId" field.
  DocumentReference? _driverId;
  DocumentReference? get driverId => _driverId;
  bool hasDriverId() => _driverId != null;

  // "timeOfJoin" field.
  DateTime? _timeOfJoin;
  DateTime? get timeOfJoin => _timeOfJoin;
  bool hasTimeOfJoin() => _timeOfJoin != null;

  // "assigned" field.
  bool? _assigned;
  bool get assigned => _assigned ?? false;
  bool hasAssigned() => _assigned != null;

  // "leftAfterWaiting" field.
  bool? _leftAfterWaiting;
  bool get leftAfterWaiting => _leftAfterWaiting ?? false;
  bool hasLeftAfterWaiting() => _leftAfterWaiting != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _driverId = snapshotData['driverId'] as DocumentReference?;
    _timeOfJoin = snapshotData['timeOfJoin'] as DateTime?;
    _assigned = snapshotData['assigned'] as bool?;
    _leftAfterWaiting = snapshotData['leftAfterWaiting'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('waitlist')
          : FirebaseFirestore.instance.collectionGroup('waitlist');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('waitlist').doc(id);

  static Stream<WaitlistRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WaitlistRecord.fromSnapshot(s));

  static Future<WaitlistRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WaitlistRecord.fromSnapshot(s));

  static WaitlistRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WaitlistRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WaitlistRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WaitlistRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WaitlistRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WaitlistRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWaitlistRecordData({
  DocumentReference? driverId,
  DateTime? timeOfJoin,
  bool? assigned,
  bool? leftAfterWaiting,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'driverId': driverId,
      'timeOfJoin': timeOfJoin,
      'assigned': assigned,
      'leftAfterWaiting': leftAfterWaiting,
    }.withoutNulls,
  );

  return firestoreData;
}

class WaitlistRecordDocumentEquality implements Equality<WaitlistRecord> {
  const WaitlistRecordDocumentEquality();

  @override
  bool equals(WaitlistRecord? e1, WaitlistRecord? e2) {
    return e1?.driverId == e2?.driverId &&
        e1?.timeOfJoin == e2?.timeOfJoin &&
        e1?.assigned == e2?.assigned &&
        e1?.leftAfterWaiting == e2?.leftAfterWaiting;
  }

  @override
  int hash(WaitlistRecord? e) => const ListEquality()
      .hash([e?.driverId, e?.timeOfJoin, e?.assigned, e?.leftAfterWaiting]);

  @override
  bool isValidKey(Object? o) => o is WaitlistRecord;
}
