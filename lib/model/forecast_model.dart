import 'dart:convert';

import 'weather_model.dart';

ForecastModel forecastModelFromJson(String str) =>
    ForecastModel.fromJson(json.decode(str));

String forecastModelToJson(ForecastModel data) => json.encode(data.toJson());

class ForecastModel {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<WeatherModel>? list;
  final City? city;

  ForecastModel({this.cod, this.message, this.cnt, this.list, this.city});

  ForecastModel copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<WeatherModel>? list,
    City? city,
  }) => ForecastModel(
    cod: cod ?? this.cod,
    message: message ?? this.message,
    cnt: cnt ?? this.cnt,
    list: list ?? this.list,
    city: city ?? this.city,
  );

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list:
        json["list"] == null
            ? []
            : List<WeatherModel>.from(
              json["list"]!.map((x) => WeatherModel.fromJson(x)),
            ),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "message": message,
    "cnt": cnt,
    "list":
        list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    "city": city?.toJson(),
  };
}

class City {
  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  City copyWith({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) => City(
    id: id ?? this.id,
    name: name ?? this.name,
    coord: coord ?? this.coord,
    country: country ?? this.country,
    population: population ?? this.population,
    timezone: timezone ?? this.timezone,
    sunrise: sunrise ?? this.sunrise,
    sunset: sunset ?? this.sunset,
  );

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coord": coord?.toJson(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}
