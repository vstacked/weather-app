// To parse this JSON data, do
//
//     final WeatherModel = WeatherModelFromJson(jsonString);

import 'dart:convert';

class WeatherModel {
  WeatherModel({
    this.city,
    this.state,
    this.country,
    this.location,
    this.current,
  });

  String city;
  String state;
  String country;
  Location location;
  Current current;

  factory WeatherModel.fromRawJson(String str) =>
      WeatherModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        current:
            json["current"] == null ? null : Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "location": location == null ? null : location.toJson(),
        "current": current == null ? null : current.toJson(),
      };
}

class Current {
  Current({
    this.weather,
    this.pollution,
  });

  Weather weather;
  Pollution pollution;

  factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        weather:
            json["weather"] == null ? null : Weather.fromJson(json["weather"]),
        pollution: json["pollution"] == null
            ? null
            : Pollution.fromJson(json["pollution"]),
      );

  Map<String, dynamic> toJson() => {
        "weather": weather == null ? null : weather.toJson(),
        "pollution": pollution == null ? null : pollution.toJson(),
      };
}

class Pollution {
  Pollution({
    this.ts,
    this.aqius,
    this.mainus,
    this.aqicn,
    this.maincn,
  });

  DateTime ts;
  int aqius;
  String mainus;
  int aqicn;
  String maincn;

  factory Pollution.fromRawJson(String str) =>
      Pollution.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pollution.fromJson(Map<String, dynamic> json) => Pollution(
        ts: json["ts"] == null ? null : DateTime.parse(json["ts"]),
        aqius: json["aqius"] == null ? null : json["aqius"],
        mainus: json["mainus"] == null ? null : json["mainus"],
        aqicn: json["aqicn"] == null ? null : json["aqicn"],
        maincn: json["maincn"] == null ? null : json["maincn"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts == null ? null : ts.toIso8601String(),
        "aqius": aqius == null ? null : aqius,
        "mainus": mainus == null ? null : mainus,
        "aqicn": aqicn == null ? null : aqicn,
        "maincn": maincn == null ? null : maincn,
      };
}

class Weather {
  Weather({
    this.ts,
    this.tp,
    this.pr,
    this.hu,
    this.ws,
    this.wd,
    this.ic,
  });

  DateTime ts;
  double tp;
  double pr;
  double hu;
  double ws;
  double wd;
  String ic;

  factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        ts: json["ts"] == null ? null : DateTime.parse(json["ts"].toString()),
        tp: json["tp"] == null ? null : double.parse(json["tp"].toString()),
        pr: json["pr"] == null ? null : double.parse(json["pr"].toString()),
        hu: json["hu"] == null ? null : double.parse(json["hu"].toString()),
        ws: json["ws"] == null ? null : double.parse(json["ws"].toString()),
        wd: json["wd"] == null ? null : double.parse(json["wd"].toString()),
        ic: json["ic"] == null ? null : json["ic"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts == null ? null : ts.toIso8601String(),
        "tp": tp == null ? null : tp,
        "pr": pr == null ? null : pr,
        "hu": hu == null ? null : hu,
        "ws": ws == null ? null : ws,
        "wd": wd == null ? null : wd,
        "ic": ic == null ? null : ic,
      };
}

class Location {
  Location({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
      };
}
