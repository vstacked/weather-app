import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/util/style.dart';
import 'screen/home.dart';
import 'package:flutter_riverpod/all.dart';

import 'service/state_manager.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final state = watch(appThemeStateNotifier);
      return MaterialApp(
        title: 'Weather App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: state.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: Home(),
      );
    });
  }
}
