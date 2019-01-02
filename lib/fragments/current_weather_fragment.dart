import 'dart:async';

import 'package:flutter/material.dart';

class CurrentWeatherModel {
  final String cityName;
  final int cityId;
  final List<CurrentWeather_Weather> weather;
  final CurrentWeather_Main main;
  String countryCode;

  CurrentWeatherModel({
    this.cityName,
    this.cityId,
    this.weather,
    this.main,
    this.countryCode
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    var nestedWeatherList = list.map(
            (input) => CurrentWeather_Weather.fromJson(input)).toList();

    return CurrentWeatherModel(
      cityName: json['name'],
      cityId: json['id'],
      weather: nestedWeatherList,
      main: CurrentWeather_Main.fromJson(json['main'])
    );
  }
}

class CurrentWeather_Weather {
  @required final int id;
  @required final String main;
  @required final String description;
  @required final String icon;

  CurrentWeather_Weather({ this.id, this.main, this.description, this.icon });

  factory CurrentWeather_Weather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather_Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon']
    );
  }
}

class CurrentWeather_Main {
  @required final double temp;
  @required final int humidity;
  @required final int minTemp;
  @required final int maxTemp;

  CurrentWeather_Main({ this.temp, this.humidity, this.minTemp, this.maxTemp });

  factory CurrentWeather_Main.fromJson(Map<String, dynamic> json) {
    return CurrentWeather_Main(
      temp: json['temp'].toDouble(),
      humidity: json['humidity'] as int,
      minTemp: json['temp_min'] as int,
      maxTemp: json['temp_max'] as int
    );
  }
}

class CurrentWeatherFragment extends StatelessWidget {
  final Future<CurrentWeatherModel> currentWeather;

  CurrentWeatherFragment({Key key, this.currentWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: FutureBuilder<CurrentWeatherModel>(
        future: currentWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var weatherModel = snapshot.data;
            return WeatherPanel(model: weatherModel);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return CircularProgressIndicator();
        },
      ),
    );
  }

}

class WeatherPanel extends StatelessWidget {
  final CurrentWeatherModel model;

  WeatherPanel({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(model.cityName, style: TextStyle(fontSize: 50)),
              Text(model.weather[0].main, style: Theme.of(context).textTheme.subhead),
              Text(model.main.temp.toString(), style: Theme.of(context).textTheme.headline)
            ],
          ),
        ),
        ListTile(
          leading: Text('Today'),
          title: Icon(Icons.album),
          trailing: Text(model.weather[0].description),
        )

      ],
    );
  }

}