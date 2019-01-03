import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

const String API_KEY = '9f234208b8a660c47018bff2fe9d0fd2';

class WeatherApi {

  final String _BASE_URL = 'api.openweathermap.org';
  final String _METRIC_UNIT = 'metric';
  final HttpClient _httpClient = HttpClient();

  Future<Map<String, dynamic>> getCurrentWeather(String cityName) async {
    final uri = Uri.https(_BASE_URL, '/data/2.5/weather', {
      'units': _METRIC_UNIT,
      'apikey': API_KEY,
      'q': cityName
    });

    return await _getApiCall(uri);
  }

  Future<Map<String, dynamic>> getFiveDaysForecast(String cityId) async {
    final uri = Uri.https(_BASE_URL, '/data/2.5/forecast', {
      'units': _METRIC_UNIT,
      'apikey': API_KEY,
      'id': cityId
    });

    return await _getApiCall(uri);
  }

  Future<Map<String, dynamic>> _getApiCall(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }
      // The response is sent as a Stream of bytes that we need to convert to a `String`.
      final responseBody = await httpResponse.transform(utf8.decoder).join();

      // Finally, the string is parsed into a JSON object.
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');

      return null;
    }
  }

}