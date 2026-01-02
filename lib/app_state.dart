import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _remainingDistance =
          prefs.getDouble('ff_remainingDistance') ?? _remainingDistance;
    });
    _safeInit(() {
      _destinationReached =
          prefs.getBool('ff_destinationReached') ?? _destinationReached;
    });
    _safeInit(() {
      _ridePlaced = prefs.getBool('ff_ridePlaced') ?? _ridePlaced;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _temp = '';
  String get temp => _temp;
  set temp(String value) {
    _temp = value;
  }

  double _remainingDistance = 0.0;
  double get remainingDistance => _remainingDistance;
  set remainingDistance(double value) {
    _remainingDistance = value;
    prefs.setDouble('ff_remainingDistance', value);
  }

  bool _destinationReached = false;
  bool get destinationReached => _destinationReached;
  set destinationReached(bool value) {
    _destinationReached = value;
    prefs.setBool('ff_destinationReached', value);
  }

  bool _ridePlaced = false;
  bool get ridePlaced => _ridePlaced;
  set ridePlaced(bool value) {
    _ridePlaced = value;
    prefs.setBool('ff_ridePlaced', value);
  }

  List<LatLng> _allPoints = [];
  List<LatLng> get allPoints => _allPoints;
  set allPoints(List<LatLng> value) {
    _allPoints = value;
  }

  void addToAllPoints(LatLng value) {
    allPoints.add(value);
  }

  void removeFromAllPoints(LatLng value) {
    allPoints.remove(value);
  }

  void removeAtIndexFromAllPoints(int index) {
    allPoints.removeAt(index);
  }

  void updateAllPointsAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    allPoints[index] = updateFn(_allPoints[index]);
  }

  void insertAtIndexInAllPoints(int index, LatLng value) {
    allPoints.insert(index, value);
  }

  List<LocationChosenStruct> _destinations = [];
  List<LocationChosenStruct> get destinations => _destinations;
  set destinations(List<LocationChosenStruct> value) {
    _destinations = value;
  }

  void addToDestinations(LocationChosenStruct value) {
    destinations.add(value);
  }

  void removeFromDestinations(LocationChosenStruct value) {
    destinations.remove(value);
  }

  void removeAtIndexFromDestinations(int index) {
    destinations.removeAt(index);
  }

  void updateDestinationsAtIndex(
    int index,
    LocationChosenStruct Function(LocationChosenStruct) updateFn,
  ) {
    destinations[index] = updateFn(_destinations[index]);
  }

  void insertAtIndexInDestinations(int index, LocationChosenStruct value) {
    destinations.insert(index, value);
  }

  LocationChosenStruct _origin = LocationChosenStruct();
  LocationChosenStruct get origin => _origin;
  set origin(LocationChosenStruct value) {
    _origin = value;
  }

  void updateOriginStruct(Function(LocationChosenStruct) updateFn) {
    updateFn(_origin);
  }

  DocumentReference? _tempRide;
  DocumentReference? get tempRide => _tempRide;
  set tempRide(DocumentReference? value) {
    _tempRide = value;
  }

  DocumentReference? _promoCodeUsed;
  DocumentReference? get promoCodeUsed => _promoCodeUsed;
  set promoCodeUsed(DocumentReference? value) {
    _promoCodeUsed = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
