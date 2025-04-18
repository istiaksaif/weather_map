import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  final String? cod;
  final String? message;

  ErrorModel({
    this.cod,
    this.message,
  });

  ErrorModel copyWith({
    String? cod,
    String? message,
  }) =>
      ErrorModel(
        cod: cod ?? this.cod,
        message: message ?? this.message,
      );

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    cod: json["cod"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "message": message,
  };
}
