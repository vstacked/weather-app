import 'dart:convert';
import 'package:weather_app/model/country_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/util/env.dart';

Future<WeatherModel> getSpecifiedCityData(
  String country,
  String state,
  String city,
) async {
  Uri uri = Uri.https(
    urlApi,
    "/v2/city",
    {
      "key": keyApi,
      "city": city,
      "state": state,
      "country": country,
    },
  );
  final response = await http.get(uri);
  if (response.statusCode == 200)
    return WeatherModel.fromJson(jsonDecode(response.body)['data']);
  throw jsonDecode(response.body)['data']['message'];
}

Future<WeatherModel> getNearestCityData() async {
  Uri url = Uri.https(urlApi, "/v2/nearest_city", {"key": keyApi});
  final response = await http.get(url);
  if (response.statusCode == 200)
    return WeatherModel.fromJson(jsonDecode(response.body)['data']);
  throw jsonDecode(response.body)['data']['message'];
}

Future<List<CountryModel>> getCountries() async {
  Uri uri = Uri.https(urlApi, "v2/countries", {"key": keyApi});
  final response = await http.get(uri);
  if (response.statusCode == 200)
    return (jsonDecode(response.body)['data'] as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();
  throw jsonDecode(response.body)['data']['message'];
}

Future<List<StateModel>> getStates(String country) async {
  Uri uri = Uri.https(urlApi, "v2/states", {
    "key": keyApi,
    "country": country,
  });
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['data'] as List)
        .map((e) => StateModel.fromJson(e))
        .toList();
  }
  throw jsonDecode(response.body)['data']['message'];
}

Future<List<CityModel>> getCities(String country, String state) async {
  Uri uri = Uri.https(urlApi, "v2/cities", {
    "key": keyApi,
    "country": country,
    "state": state,
  });
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    print((jsonDecode(response.body)['data'] as List).length);
    return (jsonDecode(response.body)['data'] as List)
        .map((e) => CityModel.fromJson(e))
        .toList();
  }
  throw jsonDecode(response.body)['data']['message'];
}
