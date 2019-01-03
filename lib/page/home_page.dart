import 'package:flutter/material.dart';
import 'package:flutter_network_app/model/weather_model.dart';
import 'package:flutter_network_app/page/city_weather_page.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

final _auckland = CityNameId(cityName: "Auckland", cityId: 2193733);
final _london = CityNameId(cityName: "London", cityId: 2643743);
final _beijing = CityNameId(cityName: "Beijing", cityId: 1816670);

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem(_auckland.cityName, Icons.cloud),
    new DrawerItem(_london.cityName, Icons.language),
    new DrawerItem(_beijing.cityName, Icons.location_city),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  CityNameId _currentCity;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        _currentCity = _auckland;
        break;
      case 1:
        _currentCity = _london;
        break;
      case 2:
        _currentCity = _beijing;
        break;
      default:
        return Text("Error");
    }

    return CityWeatherPage(city: _currentCity,);
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerItems = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerItems.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedDrawerIndex].title)
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Chandler"),
                accountEmail: Text("dc9909@hotmail.com")),
            Column(children: drawerItems)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}