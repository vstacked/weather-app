import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/params.dart';
import 'package:weather_app/service/state_manager.dart';
import 'package:weather_app/util/env.dart';
import 'package:weather_app/util/style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dateFormat = DateFormat('EEEE, d MMMM y');
  final pageController = PageController();
  int index = 0;
  String _country = "", _state = "", _city = "";
  bool _isCountry = true, _isState = false, _isSubmited = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, watch, child) {
            var data = watch(_isSubmited
                ? specifiedCityData(
                    Params(country: _country, state: _state, city: _city))
                : nearestCityData);
            // var data = watch(nearestCityData);
            return data.map(
              loading: (value) => Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (value) => Expanded(
                child: Center(
                  child: Text(
                    errorText(value.error),
                    style: Theme.of(context).textTheme.headline6,
                    textScaleFactor: 2,
                  ),
                ),
              ),
              data: (_) {
                return RefreshIndicator(
                  onRefresh: () {
                    setState(() {
                      index = 0;
                    });
                    return context.refresh(_isSubmited
                        ? specifiedCityData(Params(
                            country: _country, state: _state, city: _city))
                        : nearestCityData);
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Consumer(builder: (context, watch, child) {
                        final state = context.read(appThemeStateNotifier);
                        return Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              state.isDarkModeEnabled
                                  ? Icons.brightness_7
                                  : Icons.brightness_3,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              if (state.isDarkModeEnabled)
                                state.setLightTheme();
                              else
                                state.setDarkTheme();
                            },
                          ),
                        );
                      }),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: showPicker,
                                    child: AutoSizeText(
                                      '${_.value.city}, ${_.value.country}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                      textScaleFactor: 1.25,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if (_isSubmited)
                                  IconButton(
                                    icon: Icon(
                                      Icons.restore,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isSubmited = false;
                                      });
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: PageView(
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {
                            setState(() {
                              index = value;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Image.network(
                                      iconUrl(_.value.current.weather.ic),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          iconDesc(_.value.current.weather.ic),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          textScaleFactor: 1.1,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Table(
                                            columnWidths: {
                                              0: FlexColumnWidth(2),
                                              1: FlexColumnWidth(2),
                                            },
                                            children: [
                                              row(
                                                'Temperature',
                                                '${_.value.current.weather.tp}°C',
                                              ),
                                              row(
                                                'Humadity',
                                                '${_.value.current.weather.hu}%',
                                              ),
                                              row(
                                                'Wind',
                                                '${_.value.current.weather.ws} m/s',
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                height: 50,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Pollution',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            textScaleFactor: 1.5,
                                          ),
                                          Text(
                                            'last update ${dateFormat.format(_.value.current.pollution.ts)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            textScaleFactor: .55,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: aqiColor(
                                            _.value.current.pollution.aqius),
                                        child: Center(
                                          child: Text(
                                            '${_.value.current.pollution.aqius}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(color: primaryColor),
                                            textScaleFactor: 3.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: aqiColors.map((e) {
                                            int index = aqiColors.indexWhere(
                                                (element) => element == e);
                                            return Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    margin: EdgeInsets.only(
                                                      right: 5,
                                                      bottom: 5,
                                                    ),
                                                    color: e,
                                                  ),
                                                  Text(
                                                    aqiLevelDesc[index],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .55,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer(builder: (context, watch, child) {
                        final state = context.read(appThemeStateNotifier);
                        return Container(
                          height: 10,
                          width: double.infinity,
                          child: Center(
                            child: ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, _) => Container(
                                height: 5,
                                width: 5,
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _ == index
                                      ? (state.isDarkModeEnabled
                                          ? Colors.white
                                          : primaryColor)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'API from',
                              style: Theme.of(context).textTheme.headline6,
                              textScaleFactor: .6,
                            ),
                            SizedBox(width: 10),
                            SvgPicture.network(
                              'https://www.iqair.com/assets/logos/ic-logo-iq-air-blue.svg',
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  showPicker() {
    bool _isDisableButton = true;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: StatefulBuilder(
            builder: (context, state) => Row(
              children: [
                if (!_isCountry)
                  Center(
                    child: CupertinoButton(
                      child: Text(
                        "Back",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      onPressed: () {
                        state(() {
                          if (_isState) {
                            _isCountry = true;
                            _isState = false;
                          }
                          if (!_isCountry && !_isState) {
                            _isState = true;
                          }
                        });
                      },
                    ),
                  ),
                if (_isCountry)
                  Consumer(
                    builder: (context, watch, child) {
                      final countries = watch(supportedCountriesData);
                      return countries.map(
                        loading: (_) => Expanded(
                          flex: 3,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (_) => Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              errorText(_.error),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        data: (_) {
                          return Flexible(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(),
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                state(() {
                                  _isDisableButton =
                                      (index == 0) ? true : false;
                                  if (index != 0)
                                    _country = _.value[index - 1].country;
                                });
                              },
                              children: [
                                Center(
                                    child: Text(
                                  'Choose Country',
                                  style: Theme.of(context).textTheme.headline6,
                                )),
                              ]..addAll(_.value.map((e) {
                                  return Center(
                                    child: AutoSizeText(
                                      e.country,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      maxLines: 1,
                                    ),
                                  );
                                }).toList()),
                            ),
                          );
                        },
                      );
                    },
                  ),
                if (_isState)
                  Consumer(
                    builder: (context, watch, child) {
                      final states = watch(supportedStatesData(_country));
                      return states.map(
                        loading: (_) => Expanded(
                          flex: 3,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (_) => Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              errorText(_.error),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        data: (_) {
                          return Flexible(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(),
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                state(() {
                                  _isDisableButton =
                                      (index == 0) ? true : false;
                                  if (index != 0)
                                    _state = _.value[index - 1].state;
                                });
                              },
                              children: [
                                Center(
                                    child: Text(
                                  'Choose State',
                                  style: Theme.of(context).textTheme.headline6,
                                )),
                              ]..addAll(_.value.map((e) {
                                  return Center(
                                    child: AutoSizeText(
                                      e.state,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      maxLines: 1,
                                    ),
                                  );
                                }).toList()),
                            ),
                          );
                        },
                      );
                    },
                  ),
                if (!_isCountry && !_isState)
                  Consumer(
                    builder: (context, watch, child) {
                      final cities = watch(supportedCititesData(
                          Params(country: _country, state: _state)));
                      return cities.map(
                        loading: (_) => Expanded(
                          flex: 3,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (_) => Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              errorText(_.error),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        data: (_) {
                          // if (_city.isEmpty) _city = _.value[0].city;
                          return Flexible(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(),
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                state(() {
                                  _isDisableButton =
                                      (index == 0) ? true : false;
                                  if (index != 0)
                                    _city = _.value[index - 1].city;
                                });
                              },
                              children: [
                                Center(
                                    child: Text(
                                  'Choose City',
                                  style: Theme.of(context).textTheme.headline6,
                                )),
                              ]..addAll(_.value.map((e) {
                                  return Center(
                                    child: AutoSizeText(
                                      e.city,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      maxLines: 1,
                                    ),
                                  );
                                }).toList()),
                            ),
                          );
                        },
                      );
                    },
                  ),
                Center(
                  child: CupertinoButton(
                    child: Text(
                      !_isCountry && !_isState ? "OK" : "Next",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .headline6
                              .color
                              .withOpacity(!_isDisableButton ? 1 : .5)),
                      // style: TextTheme().bodyText1.copyWith(
                      //       color: ThemeData()
                      //           .scaffoldBackgroundColor
                      //           .withOpacity(!_isDisableButton ? 1 : .5),
                      //     ),
                    ),
                    onPressed: ((_isCountry && _country.isNotEmpty) ||
                                (_isState && _state.isNotEmpty) ||
                                (!_isCountry &&
                                    !_isState &&
                                    _city.isNotEmpty)) &&
                            !_isDisableButton
                        ? () {
                            if (!_isCountry && !_isState) {
                              context.refresh(specifiedCityData(Params(
                                  country: _country,
                                  state: _state,
                                  city: _city)));
                              setState(() {
                                _isSubmited = true;
                                _isCountry = true;
                                _isState = false;
                                Navigator.pop(context);
                              });
                            } else {
                              if (_isCountry)
                                state(() {
                                  if (_country.isNotEmpty)
                                    context
                                        .refresh(supportedStatesData(_country));
                                  _isCountry = false;
                                  _isState = true;
                                  _isDisableButton = true;
                                });
                              else if (_isState) {
                                state(() {
                                  if (_country.isNotEmpty && _state.isNotEmpty)
                                    context.refresh(supportedCititesData(Params(
                                        country: _country, state: _state)));
                                  _isState = false;
                                  _isDisableButton = true;
                                });
                              }
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TableRow row(String title, String value) {
    return TableRow(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
          textScaleFactor: .75,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headline6,
          textScaleFactor: .75,
        ),
      ],
    );
  }
}
