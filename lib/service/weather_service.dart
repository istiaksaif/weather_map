import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../model/weather_model.dart';
import 'api/api_client.dart';
import 'api/api_config.dart';
import 'location_service.dart';

class WeatherService extends StateNotifier<WeatherModel?> {
  final ApiClient apiClient;

  WeatherService({required this.apiClient}) : super(null);

  final LocationService _locationService = LocationService();
  late Position currentLocation;

  Future<Position?> getGeoLocation() async {
    Position? position = await _locationService.getLatLong(
      permissionForce: true,
    );
    return position;
    // currentLocation = position!;
  }

  Future<void> fetchWeather(Position? position) async {
    currentLocation = position!;
    final response = await apiClient.getData(
      ApiConfig.weatherUrl,
      query: {
        'lat': currentLocation.latitude.toString(),
        'lon': currentLocation.longitude.toString(),
        'appid': ApiConfig.apiKey,
      },
    );
    try {
      if (response.statusCode == 200) {
        WeatherModel weatherModel = weatherModelFromJson(response.body);
        state = weatherModel;
      }
    } catch (_) {
    } finally {}
  }
}
