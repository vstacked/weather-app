// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

class CountryModel {
  CountryModel({
    this.country,
  });

  String country;

  factory CountryModel.fromRawJson(String str) =>
      CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        country: json["country"] == null ? null : json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
      };
}

// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

class StateModel {
  StateModel({
    this.state,
  });

  String state;

  factory StateModel.fromRawJson(String str) =>
      StateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toJson() => {
        "state": state == null ? null : state,
      };
}

// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

class CityModel {
  CityModel({
    this.city,
  });

  String city;

  factory CityModel.fromRawJson(String str) =>
      CityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        city: json["city"] == null ? null : json["city"],
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
      };
}
