import 'package:flutter/material.dart';

Color primaryColor = Color(0xFF03506f);

String iconDesc(String icon) {
  switch (icon) {
    case '01d':
    case '01n':
      return 'Clear Sky';
      break;
    case '02d':
    case '02n':
      return 'Few Clouds';
      break;
    case '03d':
    case '03n':
      return 'Scattered Clouds';
      break;
    case '04d':
    case '04n':
      return 'Broken Clouds';
      break;
    case '09d':
    case '09n':
      return 'Shower Rain';
      break;
    case '10d':
    case '10n':
      return 'Rain';
      break;
    case '11d':
    case '11n':
      return 'Thunderstorm';
      break;
    case '13d':
    case '13n':
      return 'Snow';
      break;
    case '50d':
    case '50n':
      return 'Mist';
      break;
    default:
      return 'Undefined';
  }
}

List<Color> aqiColors = [
  Colors.greenAccent,
  Colors.yellowAccent,
  Colors.orangeAccent,
  Colors.redAccent,
  Colors.purple[800],
  Colors.red[900]
];

List<String> aqiLevelDesc = [
  'Good',
  'Moderate',
  'Unhealthy for Sensitive Groups',
  'Unhealty',
  'Very Unhealty',
  'Hazardous'
];

Color aqiColor(int aqi) {
  if (aqi <= 50)
    return aqiColors[0];
  else if (aqi <= 100)
    return aqiColors[1];
  else if (aqi <= 150)
    return aqiColors[2];
  else if (aqi <= 200)
    return aqiColors[3];
  else if (aqi <= 300)
    return aqiColors[4];
  else if (aqi <= 500) return aqiColors[5];
  return Colors.white;
}

String errorText(String value) =>
    "${value[0].toUpperCase()}${value.substring(1)}".replaceAll("_", " ");

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: primaryColor),
  textTheme: TextTheme(
    headline6: TextStyle(color: primaryColor),
  ),
  accentColor: primaryColor,
  canvasColor: Colors.white,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: primaryColor,
  iconTheme: IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    headline6: TextStyle(color: Colors.white),
  ),
  accentColor: Colors.white,
  canvasColor: primaryColor,
);
