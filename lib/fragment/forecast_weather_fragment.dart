import 'package:flutter/material.dart';
import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/widget/three_hour_tile.dart';

class ForecastWeatherFragment extends StatelessWidget {
  final ForecastModel model;

  ForecastWeatherFragment({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var weatherModel = model.weatherModels[index];

          return ThreeHourTile(
            model: weatherModel,
          );
        },
        itemCount: model.lineNum,
      ),
    );
  }
}
