import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../model/forecast_model.dart';
import '../model/weather_model.dart';
import '../utils/session_manager.dart';
import 'api/api_client.dart';
import 'api/api_config.dart';
import 'location_service.dart';

class SearchService extends StateNotifier<List<WeatherModel>?> {
  SearchService() : super(null);

  Future<void> fetchSavedWeatherList() async {
    try {
      final jsonString = SessionManager.getValue(kSavedLocation, value: null);
      if (jsonString != null && jsonString.isNotEmpty) {
        List<dynamic> decoded = jsonDecode(jsonString);
        List<WeatherModel> weatherList =
            decoded
                .map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
                .toList();
        state = weatherList;
      }
    } catch (e) {
      print('____$e');
    }
  }
}
