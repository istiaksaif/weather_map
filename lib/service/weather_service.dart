import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../model/weather_model.dart';
import '../utils/session_manager.dart';
import '../view/widget/show_custom_toast.dart';
import 'api/api_client.dart';
import 'api/api_config.dart';
import 'location_service.dart';

class WeatherService extends StateNotifier<WeatherModel?> {
  final ApiClient apiClient;

  WeatherService({required this.apiClient}) : super(null);

  final LocationService _locationService = LocationService();

  Future<Position?> getGeoLocation() async {
    Position? position = await _locationService.getLatLong(
      permissionForce: true,
    );
    return position;
  }

  Future<void> fetchWeather({Position? position, String? city}) async {
    final response = await apiClient.getData(
      ApiConfig.weatherUrl,
      query:
          position != null
              ? {
                'lat': position.latitude.toString(),
                'lon': position.longitude.toString(),
                'appid': ApiConfig.apiKey,
              }
              : {'q': city, 'appid': ApiConfig.apiKey},
    );
    try {
      if (response.statusCode == 200) {
        WeatherModel weatherModel = weatherModelFromJson(response.body);
        state = weatherModel;
        if (city != null) {
          saveWeatherList(weatherModel);
        }
      } else if (response.statusCode == 404) {
        showCustomToast(response.body);
      }
    } catch (_) {
    } finally {}
  }

  void saveWeatherList(WeatherModel weatherModel) {
    final jsonString = SessionManager.getValue(kSavedLocation, value: '');
    List<WeatherModel> previousList = [];

    if (jsonString.isNotEmpty) {
      try {
        List<dynamic> decoded = jsonDecode(jsonString);
        previousList =
            decoded
                .map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
                .toList();
      } catch (_) {}
    }

    previousList.add(weatherModel);

    final listAsJson = previousList.map((e) => e.toJson()).toList();
    SessionManager.setValue(kSavedLocation, jsonEncode(listAsJson));
  }
}
