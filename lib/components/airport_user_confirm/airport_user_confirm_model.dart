import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'airport_user_confirm_widget.dart' show AirportUserConfirmWidget;
import 'package:flutter/material.dart';

class AirportUserConfirmModel
    extends FlutterFlowModel<AirportUserConfirmWidget> {
  ///  Local state fields for this component.

  List<dynamic> searchResult = [];
  void addToSearchResult(dynamic item) => searchResult.add(item);
  void removeFromSearchResult(dynamic item) => searchResult.remove(item);
  void removeAtIndexFromSearchResult(int index) => searchResult.removeAt(index);
  void insertAtIndexInSearchResult(int index, dynamic item) =>
      searchResult.insert(index, item);
  void updateSearchResultAtIndex(int index, Function(dynamic) updateFn) =>
      searchResult[index] = updateFn(searchResult[index]);

  dynamic chosen;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - randomNumber] action in airportUserConfirm widget.
  String? randNo;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  AirportsRecord? airportsGot;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  AirportsRecord? airPortMade;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
