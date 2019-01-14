import 'package:flutter/material.dart';
import 'package:flutter_network_app/model/weather_model.dart';

class CurrentWeatherFragment extends StatelessWidget {
  final CurrentWeatherModel model;

  CurrentWeatherFragment({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Column(
        children: <Widget>[
          Text(model.cityName, style: TextStyle(fontSize: 50)),
          Text(model.weather[0].main, style: Theme.of(context).textTheme.subhead),
          Text(model.main.temp.toString(), style: Theme.of(context).textTheme.headline),
        ],
      ),
    );
  }
}

