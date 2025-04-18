import 'package:intl/intl.dart';

import '../model/weather_model.dart';

class Constant {
  static String kelvinToFahrenheit(double? kelvinTemp) {
    if (kelvinTemp == null) {
      return '0 °F';
    }
    double fahrenheit = (kelvinTemp - 273.15) * 9 / 5 + 32;
    return '${fahrenheit.toStringAsFixed(1)} °F';
  }

  static String getShortDayName(String? dateString) {
    if (dateString == null) {
      return '';
    }
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('E').format(dateTime);
  }

  static String formatTo12HourTime(String? dateTimeString) {
    if (dateTimeString == null) {
      return '';
    }
    final dateTime = DateTime.parse(dateTimeString);
    final hour = dateTime.hour;
    final minute = dateTime.minute;

    final suffix = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;

    return '${formattedHour.toString().padLeft(2, '0')} $suffix';
  }

  static String formatToDayDate(String? dateTimeString) {
    if(dateTimeString==null){
      return '';
    }
    final dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('EEEE, d MMMM'); // Monday, 18 March
    return formatter.format(dateTime);
  }

  static List<WeatherModel> getUniqueDailyForecasts(
    List<WeatherModel> forecastList,
  ) {
    final seenDates = <String>{};
    final uniqueList = <WeatherModel>[];

    for (var item in forecastList) {
      if (item.dtTxt != null && item.dtTxt!.isNotEmpty) {
        final dateOnly = getShortDayName(item.dtTxt);
        if (!seenDates.contains(dateOnly)) {
          seenDates.add(dateOnly);
          uniqueList.add(item);
        }
      }
    }

    return uniqueList;
  }

  static List<WeatherModel> getSameDayForecasts(
    List<WeatherModel> forecastList,
    String day,
  ) {
    final uniqueList = <WeatherModel>[];

    for (var item in forecastList) {
      if (item.dtTxt != null && item.dtTxt!.isNotEmpty) {
        final dateOnly = getShortDayName(item.dtTxt);
        if (day == dateOnly) {
          uniqueList.add(item);
        }
      }
    }

    return uniqueList;
  }
}
