import 'dart:convert';

import 'package:room_finder_flutter/models/autocomplete_prediction.dart';

class PlaceAutoCompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;
  PlaceAutoCompleteResponse({this.status, this.predictions});
  factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null
          ? json['predictions']
              .map<AutocompletePrediction>(
                  (json) => AutocompletePrediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static PlaceAutoCompleteResponse parseAutocompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutoCompleteResponse.fromJson(parsed);
  }
}
