import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/weather_model.dart';
import '../service/api/api_client.dart';
import '../service/api/api_config.dart';
import '../service/forecast_service.dart';
import '../service/search_service.dart';
import '../service/weather_service.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(appBaseUrl: ApiConfig.baseUrl);
});

final weatherServiceProvider =
    StateNotifierProvider<WeatherService, WeatherModel?>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return WeatherService(apiClient: apiClient);
    });

final forecastServiceProvider =
    StateNotifierProvider<ForecastService, List<WeatherModel>?>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return ForecastService(apiClient: apiClient);
    });

final searchServiceProvider =
    StateNotifierProvider<SearchService, List<WeatherModel>?>((ref) {
      return SearchService();
    });
