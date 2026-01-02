import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RidesRecord extends FirestoreRecord {
  RidesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "paid" field.
  bool? _paid;
  bool get paid => _paid ?? false;
  bool hasPaid() => _paid != null;

  // "customer" field.
  DocumentReference? _customer;
  DocumentReference? get customer => _customer;
  bool hasCustomer() => _customer != null;

  // "driver" field.
  DocumentReference? _driver;
  DocumentReference? get driver => _driver;
  bool hasDriver() => _driver != null;

  // "rideType" field.
  DocumentReference? _rideType;
  DocumentReference? get rideType => _rideType;
  bool hasRideType() => _rideType != null;

  // "accepted" field.
  bool? _accepted;
  bool get accepted => _accepted ?? false;
  bool hasAccepted() => _accepted != null;

  // "completedButNotPaid" field.
  bool? _completedButNotPaid;
  bool get completedButNotPaid => _completedButNotPaid ?? false;
  bool hasCompletedButNotPaid() => _completedButNotPaid != null;

  // "started" field.
  bool? _started;
  bool get started => _started ?? false;
  bool hasStarted() => _started != null;

  // "pickupTime" field.
  DateTime? _pickupTime;
  DateTime? get pickupTime => _pickupTime;
  bool hasPickupTime() => _pickupTime != null;

  // "basicFare" field.
  double? _basicFare;
  double get basicFare => _basicFare ?? 0.0;
  bool hasBasicFare() => _basicFare != null;

  // "distanceFare" field.
  double? _distanceFare;
  double get distanceFare => _distanceFare ?? 0.0;
  bool hasDistanceFare() => _distanceFare != null;

  // "timeFare" field.
  double? _timeFare;
  double get timeFare => _timeFare ?? 0.0;
  bool hasTimeFare() => _timeFare != null;

  // "waitTimeAtPickupFare" field.
  double? _waitTimeAtPickupFare;
  double get waitTimeAtPickupFare => _waitTimeAtPickupFare ?? 0.0;
  bool hasWaitTimeAtPickupFare() => _waitTimeAtPickupFare != null;

  // "paidAt" field.
  DateTime? _paidAt;
  DateTime? get paidAt => _paidAt;
  bool hasPaidAt() => _paidAt != null;

  // "canceled" field.
  bool? _canceled;
  bool get canceled => _canceled ?? false;
  bool hasCanceled() => _canceled != null;

  // "driverArriveTime" field.
  DateTime? _driverArriveTime;
  DateTime? get driverArriveTime => _driverArriveTime;
  bool hasDriverArriveTime() => _driverArriveTime != null;

  // "start" field.
  LatLng? _start;
  LatLng? get start => _start;
  bool hasStart() => _start != null;

  // "destination" field.
  List<LatLng>? _destination;
  List<LatLng> get destination => _destination ?? const [];
  bool hasDestination() => _destination != null;

  // "destinationNames" field.
  List<String>? _destinationNames;
  List<String> get destinationNames => _destinationNames ?? const [];
  bool hasDestinationNames() => _destinationNames != null;

  // "airportRide" field.
  bool? _airportRide;
  bool get airportRide => _airportRide ?? false;
  bool hasAirportRide() => _airportRide != null;

  // "whichAirport" field.
  DocumentReference? _whichAirport;
  DocumentReference? get whichAirport => _whichAirport;
  bool hasWhichAirport() => _whichAirport != null;

  // "startName" field.
  String? _startName;
  String get startName => _startName ?? '';
  bool hasStartName() => _startName != null;

  // "reservation" field.
  bool? _reservation;
  bool get reservation => _reservation ?? false;
  bool hasReservation() => _reservation != null;

  // "reservationTime" field.
  DateTime? _reservationTime;
  DateTime? get reservationTime => _reservationTime;
  bool hasReservationTime() => _reservationTime != null;

  // "promoCodeUsed" field.
  DocumentReference? _promoCodeUsed;
  DocumentReference? get promoCodeUsed => _promoCodeUsed;
  bool hasPromoCodeUsed() => _promoCodeUsed != null;

  // "driverComingToPickReservation" field.
  bool? _driverComingToPickReservation;
  bool get driverComingToPickReservation =>
      _driverComingToPickReservation ?? false;
  bool hasDriverComingToPickReservation() =>
      _driverComingToPickReservation != null;

  // "availabilityMarked" field.
  bool? _availabilityMarked;
  bool get availabilityMarked => _availabilityMarked ?? false;
  bool hasAvailabilityMarked() => _availabilityMarked != null;

  // "driverShare" field.
  double? _driverShare;
  double get driverShare => _driverShare ?? 0.0;
  bool hasDriverShare() => _driverShare != null;

  void _initializeFields() {
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _paid = snapshotData['paid'] as bool?;
    _customer = snapshotData['customer'] as DocumentReference?;
    _driver = snapshotData['driver'] as DocumentReference?;
    _rideType = snapshotData['rideType'] as DocumentReference?;
    _accepted = snapshotData['accepted'] as bool?;
    _completedButNotPaid = snapshotData['completedButNotPaid'] as bool?;
    _started = snapshotData['started'] as bool?;
    _pickupTime = snapshotData['pickupTime'] as DateTime?;
    _basicFare = castToType<double>(snapshotData['basicFare']);
    _distanceFare = castToType<double>(snapshotData['distanceFare']);
    _timeFare = castToType<double>(snapshotData['timeFare']);
    _waitTimeAtPickupFare =
        castToType<double>(snapshotData['waitTimeAtPickupFare']);
    _paidAt = snapshotData['paidAt'] as DateTime?;
    _canceled = snapshotData['canceled'] as bool?;
    _driverArriveTime = snapshotData['driverArriveTime'] as DateTime?;
    _start = snapshotData['start'] as LatLng?;
    _destination = getDataList(snapshotData['destination']);
    _destinationNames = getDataList(snapshotData['destinationNames']);
    _airportRide = snapshotData['airportRide'] as bool?;
    _whichAirport = snapshotData['whichAirport'] as DocumentReference?;
    _startName = snapshotData['startName'] as String?;
    _reservation = snapshotData['reservation'] as bool?;
    _reservationTime = snapshotData['reservationTime'] as DateTime?;
    _promoCodeUsed = snapshotData['promoCodeUsed'] as DocumentReference?;
    _driverComingToPickReservation =
        snapshotData['driverComingToPickReservation'] as bool?;
    _availabilityMarked = snapshotData['availabilityMarked'] as bool?;
    _driverShare = castToType<double>(snapshotData['driverShare']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rides');

  static Stream<RidesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RidesRecord.fromSnapshot(s));

  static Future<RidesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RidesRecord.fromSnapshot(s));

  static RidesRecord fromSnapshot(DocumentSnapshot snapshot) => RidesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RidesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RidesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RidesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RidesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRidesRecordData({
  DateTime? startTime,
  DateTime? endTime,
  bool? paid,
  DocumentReference? customer,
  DocumentReference? driver,
  DocumentReference? rideType,
  bool? accepted,
  bool? completedButNotPaid,
  bool? started,
  DateTime? pickupTime,
  double? basicFare,
  double? distanceFare,
  double? timeFare,
  double? waitTimeAtPickupFare,
  DateTime? paidAt,
  bool? canceled,
  DateTime? driverArriveTime,
  LatLng? start,
  bool? airportRide,
  DocumentReference? whichAirport,
  String? startName,
  bool? reservation,
  DateTime? reservationTime,
  DocumentReference? promoCodeUsed,
  bool? driverComingToPickReservation,
  bool? availabilityMarked,
  double? driverShare,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
      'paid': paid,
      'customer': customer,
      'driver': driver,
      'rideType': rideType,
      'accepted': accepted,
      'completedButNotPaid': completedButNotPaid,
      'started': started,
      'pickupTime': pickupTime,
      'basicFare': basicFare,
      'distanceFare': distanceFare,
      'timeFare': timeFare,
      'waitTimeAtPickupFare': waitTimeAtPickupFare,
      'paidAt': paidAt,
      'canceled': canceled,
      'driverArriveTime': driverArriveTime,
      'start': start,
      'airportRide': airportRide,
      'whichAirport': whichAirport,
      'startName': startName,
      'reservation': reservation,
      'reservationTime': reservationTime,
      'promoCodeUsed': promoCodeUsed,
      'driverComingToPickReservation': driverComingToPickReservation,
      'availabilityMarked': availabilityMarked,
      'driverShare': driverShare,
    }.withoutNulls,
  );

  return firestoreData;
}

class RidesRecordDocumentEquality implements Equality<RidesRecord> {
  const RidesRecordDocumentEquality();

  @override
  bool equals(RidesRecord? e1, RidesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.paid == e2?.paid &&
        e1?.customer == e2?.customer &&
        e1?.driver == e2?.driver &&
        e1?.rideType == e2?.rideType &&
        e1?.accepted == e2?.accepted &&
        e1?.completedButNotPaid == e2?.completedButNotPaid &&
        e1?.started == e2?.started &&
        e1?.pickupTime == e2?.pickupTime &&
        e1?.basicFare == e2?.basicFare &&
        e1?.distanceFare == e2?.distanceFare &&
        e1?.timeFare == e2?.timeFare &&
        e1?.waitTimeAtPickupFare == e2?.waitTimeAtPickupFare &&
        e1?.paidAt == e2?.paidAt &&
        e1?.canceled == e2?.canceled &&
        e1?.driverArriveTime == e2?.driverArriveTime &&
        e1?.start == e2?.start &&
        listEquality.equals(e1?.destination, e2?.destination) &&
        listEquality.equals(e1?.destinationNames, e2?.destinationNames) &&
        e1?.airportRide == e2?.airportRide &&
        e1?.whichAirport == e2?.whichAirport &&
        e1?.startName == e2?.startName &&
        e1?.reservation == e2?.reservation &&
        e1?.reservationTime == e2?.reservationTime &&
        e1?.promoCodeUsed == e2?.promoCodeUsed &&
        e1?.driverComingToPickReservation ==
            e2?.driverComingToPickReservation &&
        e1?.availabilityMarked == e2?.availabilityMarked &&
        e1?.driverShare == e2?.driverShare;
  }

  @override
  int hash(RidesRecord? e) => const ListEquality().hash([
        e?.startTime,
        e?.endTime,
        e?.paid,
        e?.customer,
        e?.driver,
        e?.rideType,
        e?.accepted,
        e?.completedButNotPaid,
        e?.started,
        e?.pickupTime,
        e?.basicFare,
        e?.distanceFare,
        e?.timeFare,
        e?.waitTimeAtPickupFare,
        e?.paidAt,
        e?.canceled,
        e?.driverArriveTime,
        e?.start,
        e?.destination,
        e?.destinationNames,
        e?.airportRide,
        e?.whichAirport,
        e?.startName,
        e?.reservation,
        e?.reservationTime,
        e?.promoCodeUsed,
        e?.driverComingToPickReservation,
        e?.availabilityMarked,
        e?.driverShare
      ]);

  @override
  bool isValidKey(Object? o) => o is RidesRecord;
}
