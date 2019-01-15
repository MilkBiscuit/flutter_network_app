import 'package:flutter/material.dart';
import 'package:flutter_network_app/helper/shared_pref_helper.dart';
import 'package:flutter_network_app/page/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPrefHelper();

    return MaterialApp(
      title: 'NavigationDrawer Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}