import 'package:flutter/material.dart';
import 'package:flutter_network_app/fragments/current_weather_fragment.dart';
import 'package:flutter_network_app/fragments/second_fragment.dart';
import 'package:flutter_network_app/http/current_weather_api.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Auckland Weather", Icons.cloud),
    new DrawerItem("Pizza", Icons.local_pizza),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

Future<CurrentWeatherModel> _fetchCurrentWeather() async {
  var http = WeatherApi();
  final jsonText = await http.getCurrentWeather('Auckland');

  if (jsonText != null) {
    // If the call to the server was successful, parse the JSON
    return CurrentWeatherModel.fromJson(jsonText);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load current weather');
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new CurrentWeatherFragment(
          currentWeather: _fetchCurrentWeather(),
        );
      case 1:
        return new SecondFragment();
      default:
        return new Text("Error");
    }
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