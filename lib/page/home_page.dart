import 'package:flutter/material.dart';
import 'package:flutter_network_app/helper/shared_pref_helper.dart';
import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/page/city_weather_page.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

//final _auckland = CityNameId(cityName: "Auckland", cityId: 2193733);
//final _london = CityNameId(cityName: "London", cityId: 2643743);
//final _beijing = CityNameId(cityName: "Beijing", cityId: 1816670);

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  final helper = SharedPrefHelper();

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final cityList = helper.getSavedCities();
    final drawerItems = cityList.map(
      (city) => DrawerItem(city.cityName, Icons.location_city)
    ).toList();
    final drawerWidgets = <Widget>[];

    for (var i = 0; i < drawerItems.length; i++) {
      var drawerData = drawerItems[i];
      drawerWidgets.add(
          new ListTile(
            leading: new Icon(drawerData.icon),
            title: new Text(drawerData.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text(drawerItems[_selectedDrawerIndex].title)
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Chandler"),
                accountEmail: Text("dc9909@hotmail.com")),
            Column(children: drawerWidgets)
          ],
        ),
      ),
      body: CityWeatherPage(city: cityList[_selectedDrawerIndex],),
    );
  }
}