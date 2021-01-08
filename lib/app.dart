import 'package:flutter/material.dart';

import './pages/BusList.dart';
import './pages/Map.dart';
import './pages/Sketch.dart';
import './pages/Settings.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  int _selectedPage = 0 ;
  final _pageOptions = [
    SketchPage(),
    MapPage(),
    BusListPage(),
    SettingsPage()
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBusWay',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: new AppBar(title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text('MyBusWay'), Image(image:AssetImage('./images/rdx-logo.png'), height:20)])),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Sketch'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Map',              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.departure_board),
              label: 'Buses'
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.settings),
            //   label: 'Settings'
            // ),
          ]
        ),

      ) 
    );
  }
}
