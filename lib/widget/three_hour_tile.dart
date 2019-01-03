import 'package:flutter/material.dart';
import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/util/date_time_util.dart';
import 'package:flutter_network_app/util/weather_icon_util.dart';

class ThreeHourTile extends StatelessWidget {
  final WeatherModel model;

  ThreeHourTile({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tempRange = model.main.minTemp.toStringAsFixed(1) + ' ~ ' + model.main.maxTemp.toStringAsFixed(1);

    return ListTile(
      leading: Container(
        width: 150,
        child: Text(
          DateTimeUtil.formatThreeHourDate(model.currentMilliseconds),
          style: TextStyle(fontSize: 18)),
      ),
      title: Image.asset(
        WeatherIconUtil.getWeatherIcon(model.weather[0].id),
        width: 30,
        height: 30,
      ),
      trailing: Container(
        width: 150,
        child: Text(tempRange, textAlign: TextAlign.end),
      ),
    );
  }

}