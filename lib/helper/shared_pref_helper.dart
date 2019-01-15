import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/util/collection_util.dart';
import 'package:flutter_network_app/util/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_CITY_LIST = "CityList";
const String PREF_KEY_CITY_ID_LIST = "CityIdList";

class SharedPrefHelper {

  static final SharedPrefHelper _instance = SharedPrefHelper._internal();
  static SharedPreferences sharedPrefs;

  factory SharedPrefHelper() {
    return _instance;
  }

  SharedPrefHelper._internal() {
    initSharedPref();
  }

  initSharedPref() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  String getSharedPrefString(String prefKey) {
    return sharedPrefs.getString(prefKey);
  }

  void setSharedPrefString(String prefKey, String value) {
    sharedPrefs.setString(prefKey, value);
  }

  List<String> getSharedPrefStringList(String prefKey) {
    return sharedPrefs.getStringList(prefKey);
  }

  void setSharedPrefStringList(String prefKey, List<String> value) {
    sharedPrefs.setStringList(prefKey, value);
  }

  List<CityNameId> getSavedCities() {
    if (sharedPrefs != null) {
      final cityNameList = getSharedPrefStringList(PREF_KEY_CITY_LIST);
      final cityIdList = getSharedPrefStringList(PREF_KEY_CITY_ID_LIST);
      if (CollectionUtil.notNullOrEmpty(cityNameList)
          && CollectionUtil.notNullOrEmpty(cityIdList) ) {
        final cityList = List<CityNameId>();
        for (int i = 0; i < cityNameList.length && i < cityIdList.length; i++) {
          final cityId = StringUtil.parseInt(cityIdList[i]);
          final city = CityNameId(cityName: cityNameList[i], cityId: cityId);

          cityList.add(city);
        }

        return cityList;
      }

      setSharedPrefStringList(PREF_KEY_CITY_LIST, <String>["Auckland"]);
      setSharedPrefStringList(PREF_KEY_CITY_ID_LIST, <String>["2193733"]);
    }

    return [CityNameId(cityName: "Auckland", cityId: 2193733)];
  }

}