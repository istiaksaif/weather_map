import 'package:geolocator/geolocator.dart';
import '../model/weather_model.dart';
import 'api/api_client.dart';
import 'api/api_config.dart';
import 'location_service.dart';

class WeatherService {
  final ApiClient apiClient;

  WeatherService({required this.apiClient});

  final LocationService _locationService = LocationService();
  late Position currentLocation;

  Future<void> getGeoLocation() async {
    Position? position = await _locationService.getLatLong(
      permissionForce: true,
    );
    currentLocation = position!;
  }

  Future<void> fetchWeather() async {
    await getGeoLocation();
    final response = await apiClient.getData(
      ApiConfig.weatherUrl,
      query: {
        'lat': currentLocation.latitude,
        'lon': currentLocation.longitude,
        'appid': ApiConfig.apiKey,
      },
    );
    try {
      if (response.statusCode == 200) {
        WeatherModel weatherModel = weatherModelFromJson(response.body);
      }
    } catch (_) {
    } finally {}
  }
}
