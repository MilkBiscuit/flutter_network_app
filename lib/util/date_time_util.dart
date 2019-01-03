import 'dart:core';
import 'package:date_format/date_format.dart';

const List<String> DATE_MONTH_WEEKDAY = const [HH, ':', nn, '   ', D];

String formatThreeHourDate(int timeMilliseconds) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(timeMilliseconds, isUtc: true);

  return formatDate(dateTime, DATE_MONTH_WEEKDAY);
}