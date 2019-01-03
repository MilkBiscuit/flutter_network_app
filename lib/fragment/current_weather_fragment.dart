import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/widget/three_hour_tile.dart';

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
      children: <Widget>[
        Text(model.cityName, style: TextStyle(fontSize: 50)),
        Text(model.weather[0].main, style: Theme.of(context).textTheme.subhead),
        Text(model.main.temp.toString(), style: Theme.of(context).textTheme.headline),
      ],
    );
  }

}