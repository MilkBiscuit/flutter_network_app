import 'package:flutter/material.dart';
import 'package:flutter_network_app/constant/primitive.dart';

class CurrentWeatherModel extends WeatherModel {
  final String cityName;
  final int cityId;
  String countryCode;

  CurrentWeatherModel(
    this.cityName,
    this.cityId,
    int currentTimeSeconds,
    List<_NestedWeather> weather,
    _WeatherMain main,
    {this.countryCode}
  ) : super (currentMilliseconds: currentTimeSeconds, weather: weather, main: main);

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    var parent = WeatherModel.fromJson(json);

    return CurrentWeatherModel(
        json['name'],
        json['id'],
        parent.currentMilliseconds,
        parent.weather,
        parent.main,
    );
  }
}

class WeatherModel {
  final int currentMilliseconds;
  final List<_NestedWeather> weather;
  final _WeatherMain main;

  WeatherModel({
    this.currentMilliseconds,
    this.weather,
    this.main
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    var nestedWeatherList = list.map(
            (input) => _NestedWeather.fromJson(input)).toList();
    var currentSeconds = json['dt'] as int;

    return WeatherModel(
      currentMilliseconds: currentSeconds * MILLISECONDS_PER_SECOND,
      weather: nestedWeatherList,
      main: _WeatherMain.fromJson(json['main'])
    );
  }
}

class _NestedWeather {
  @required final int id;
  @required final String main;
  @required final String description;
  @required final String icon;

  _NestedWeather({ this.id, this.main, this.description, this.icon });

  factory _NestedWeather.fromJson(Map<String, dynamic> json) {
    return _NestedWeather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']
    );
  }
}

class _WeatherMain {
  @required final int humidity;
  @required final double temp;
  @required final double minTemp;
  @required final double maxTemp;

  _WeatherMain({ this.temp, this.humidity, this.minTemp, this.maxTemp });

  factory _WeatherMain.fromJson(Map<String, dynamic> json) {
    return _WeatherMain(
        temp: json['temp'].toDouble(),
        humidity: json['humidity'].toInt(),
        minTemp: json['temp_min'].toDouble(),
        maxTemp: json['temp_max'].toDouble()
    );
  }
}