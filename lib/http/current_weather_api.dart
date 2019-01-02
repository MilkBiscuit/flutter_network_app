import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

class CurrentWeatherApi {

  final String _url = 'api.openweathermap.org';
  final HttpClient _httpClient = HttpClient();

  Future<Map<String, dynamic>> get(String path) async {
    final uri = Uri.https(_url, path, {
      'units': 'metric',
      'apikey': '9f234208b8a660c47018bff2fe9d0fd2',
      'q': 'Auckland'
    });

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