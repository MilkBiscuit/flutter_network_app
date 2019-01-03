import 'package:flutter/material.dart';
import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/util/date_time_util.dart';

class ThreeHourTile extends StatelessWidget {
  final WeatherModel model;

  ThreeHourTile({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tempRange = model.main.minTemp.toStringAsFixed(1) + ' ~ ' + model.main.maxTemp.toStringAsFixed(1);

    return ListTile(
      leading: Container(
        width: 150,
        child: Text(formatThreeHourDate(model.currentMilliseconds), style: TextStyle(fontSize: 18)),
      ),
      title: Icon(Icons.album),
      trailing: Container(
        width: 150,
        child: Text(tempRange, textAlign: TextAlign.end),
      ),
    );
  }

}