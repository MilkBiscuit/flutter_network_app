import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_network_app/fragment/current_weather_fragment.dart';
import 'package:flutter_network_app/fragment/forecast_weather_fragment.dart';
import 'package:flutter_network_app/http/weather_api.dart';
import 'package:flutter_network_app/model/weather_model.dart';

Future<CurrentWeatherModel> _fetchCurrentWeather(String cityName) async {
  var http = WeatherApi();
  final jsonText = await http.getCurrentWeather(cityName);

  if (jsonText != null) {
    // If the call to the server was successful, parse the JSON
    return CurrentWeatherModel.fromJson(jsonText);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load current weather');
  }
}

Future<ForecastModel> _fetchForecast(int cityId) async {
  var http = WeatherApi();
  final jsonText = await http.getFiveDaysForecast(cityId.toString());

  if (jsonText != null) {
    // If the call to the server was successful, parse the JSON
    return ForecastModel.fromJson(jsonText);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load five days forecast');
  }
}

class CityWeatherPage extends StatefulWidget {
  final CityNameId city;

  CityWeatherPage({@required this.city})
      : assert (city != null && city.cityName != null && city.cityId != null);

  @override
  CityWeatherPageState createState() => CityWeatherPageState();
}

class CityWeatherPageState extends State<CityWeatherPage> {
  Future<CurrentWeatherModel> _currentWeatherData;
  Future<ForecastModel> _forecastData;

  @override
  void initState() {
    super.initState();

    _fetchWeatherData();
  }

  @override
  void didUpdateWidget(CityWeatherPage old) {
    super.didUpdateWidget(old);

    if (old.city.cityId != widget.city.cityId) {
      _fetchWeatherData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CurrentWeatherFragment(
          currentWeather: _currentWeatherData,
        ),
        Expanded(
          child: ForecastWeatherFragment(
            forecastModel: _forecastData,
          ),
        )
      ],
    );
  }

  void _fetchWeatherData() {
    setState(() {
      _currentWeatherData = _fetchCurrentWeather(widget.city.cityName);
      _forecastData = _fetchForecast(widget.city.cityId);
    });
  }

}