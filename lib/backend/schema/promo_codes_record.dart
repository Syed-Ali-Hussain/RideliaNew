import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PromoCodesRecord extends FirestoreRecord {
  PromoCodesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  bool hasCode() => _code != null;

  // "expDate" field.
  DateTime? _expDate;
  DateTime? get expDate => _expDate;
  bool hasExpDate() => _expDate != null;

  // "claimed" field.
  bool? _claimed;
  bool get claimed => _claimed ?? false;
  bool hasClaimed() => _claimed != null;

  // "absoluteDiscount" field.
  double? _absoluteDiscount;
  double get absoluteDiscount => _absoluteDiscount ?? 0.0;
  bool hasAbsoluteDiscount() => _absoluteDiscount != null;

  // "percentageDiscount" field.
  double? _percentageDiscount;
  double get percentageDiscount => _percentageDiscount ?? 0.0;
  bool hasPercentageDiscount() => _percentageDiscount != null;

  void _initializeFields() {
    _code = snapshotData['code'] as String?;
    _expDate = snapshotData['expDate'] as DateTime?;
    _claimed = snapshotData['claimed'] as bool?;
    _absoluteDiscount = castToType<double>(snapshotData['absoluteDiscount']);
    _percentageDiscount =
        castToType<double>(snapshotData['percentageDiscount']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('promoCodes');

  static Stream<PromoCodesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PromoCodesRecord.fromSnapshot(s));

  static Future<PromoCodesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PromoCodesRecord.fromSnapshot(s));

  static PromoCodesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PromoCodesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PromoCodesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PromoCodesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PromoCodesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PromoCodesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPromoCodesRecordData({
  String? code,
  DateTime? expDate,
  bool? claimed,
  double? absoluteDiscount,
  double? percentageDiscount,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'code': code,
      'expDate': expDate,
      'claimed': claimed,
      'absoluteDiscount': absoluteDiscount,
      'percentageDiscount': percentageDiscount,
    }.withoutNulls,
  );

  return firestoreData;
}

class PromoCodesRecordDocumentEquality implements Equality<PromoCodesRecord> {
  const PromoCodesRecordDocumentEquality();

  @override
  bool equals(PromoCodesRecord? e1, PromoCodesRecord? e2) {
    return e1?.code == e2?.code &&
        e1?.expDate == e2?.expDate &&
        e1?.claimed == e2?.claimed &&
        e1?.absoluteDiscount == e2?.absoluteDiscount &&
        e1?.percentageDiscount == e2?.percentageDiscount;
  }

  @override
  int hash(PromoCodesRecord? e) => const ListEquality().hash([
        e?.code,
        e?.expDate,
        e?.claimed,
        e?.absoluteDiscount,
        e?.percentageDiscount
      ]);

  @override
  bool isValidKey(Object? o) => o is PromoCodesRecord;
}
