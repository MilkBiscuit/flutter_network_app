import 'dart:core';

class WeatherIconUtil {

  static String getWeatherIcon(int weatherId) {
    if (_isClear(weatherId)) {
      return 'assets/icons/ic_clear.png';
    } else if (_isCloud(weatherId)) {
      return 'assets/icons/ic_cloud.png';
    } else if (_isRain(weatherId)) {
      return 'assets/icons/ic_rain.png';
    } else if (_isDrizzle(weatherId)) {
      return 'assets/icons/ic_drizzle.png';
    } else if (_isStorm(weatherId)) {
      return 'assets/icons/ic_storm.png';
    } else if (_isFog(weatherId)) {
      return 'assets/icons/ic_fog.png';
    } else {
      return 'assets/icons/ic_unknown.png';
    }
  }

  static bool _isCloud(int weatherId) {
    return weatherId >= 801 && weatherId <= 804;
  }

  static bool _isClear(int weatherId) {
    return weatherId == 800;
  }

  static bool _isFog(int weatherId) {
    return weatherId >= 701 && weatherId <= 760;
  }

  static bool _isRain(int weatherId) {
    return weatherId >= 500 && weatherId <= 531 && weatherId != 511;
  }

  static bool _isDrizzle(int weatherId) {
    return weatherId >= 300 && weatherId <= 321;
  }

  static bool _isStorm(int weatherId) {
    return weatherId >= 200 && weatherId <= 232 || weatherId == 761 || weatherId == 781;
  }

}
