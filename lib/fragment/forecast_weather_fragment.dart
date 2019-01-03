import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/widget/three_hour_tile.dart';

class ForecastWeatherFragment extends StatelessWidget {
  final Future<ForecastModel> forecastModel;

  ForecastWeatherFragment({Key key, this.forecastModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: FutureBuilder<ForecastModel>(
        future: forecastModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return ForecastList(model: snapshot.data);
          } else if (snapshot.hasError) {

            return Text("${snapshot.error}");
          }

          return Container();
        },
      ),
    );
  }

}

class ForecastList extends StatelessWidget {
  final ForecastModel model;

  ForecastList({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var weatherModel = model.weatherModels[index];

        return ThreeHourTile(
          model: weatherModel,
        );
      },
      itemCount: model.lineNum,
    );
  }

}