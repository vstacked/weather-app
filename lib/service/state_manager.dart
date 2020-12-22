import 'package:flutter_riverpod/all.dart';
import 'package:weather_app/model/country_model.dart';
import 'package:weather_app/model/params.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/app_theme_state.dart';
import 'package:weather_app/service/api.dart';

final nearestCityData =
    FutureProvider<WeatherModel>((_) async => await getNearestCityData());
final supportedCountriesData =
    FutureProvider<List<CountryModel>>((_) async => await getCountries());
final supportedStatesData = FutureProvider.family<List<StateModel>, String>(
    (states, country) async => await getStates(country));
final supportedCititesData = FutureProvider.family<List<CityModel>, Params>(
    (states, param) async => await getCities(param.country, param.state));
final specifiedCityData = FutureProvider.family<WeatherModel, Params>(
    (states, param) async =>
        await getSpecifiedCityData(param.country, param.state, param.city));

// Theme
final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());
