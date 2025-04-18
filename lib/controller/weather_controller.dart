import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/api/api_client.dart';
import '../service/api/api_config.dart';
import '../service/weather_service.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(appBaseUrl: ApiConfig.baseUrl);
});

final weatherServiceProvider = Provider<WeatherService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return WeatherService(apiClient: apiClient);
});