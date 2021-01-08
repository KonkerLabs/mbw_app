import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import './model/Line.dart';
import './model/Car.dart';
import 'component/BusLineCard.dart';


class BusListPage extends StatefulWidget {
  BusListState createState() => BusListState();
}

class FetchDataException implements Exception {
 final _message;
 FetchDataException([this._message]);

String toString() {
if (_message == null) return "Exception";
  return "Exception: $_message";
 }
}

class BusListState extends State<BusListPage> {

  bool isProduction = bool.fromEnvironment('dart.vm.product');
  String baseUrl;
  List<Line> _lines = []; // [Line(name:'Amarelo', color:'yellow'), Line(name:'Verde', color:'green'), Line(name:'Rosa', color:'pink'), Line(name:'Azul', color:'blue')];
  List<Car> _cars = [];
  Map<String, Line> _lineIndex = Map<String, Line>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();


  Future<List<Line>> fetchLines() async {
    List<Line> lines;
    var response = await http.get('$baseUrl/lines');

    print(response.body);

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    print('decoded');
    print(parsed);
    print('size = ${parsed.length}');

    lines=parsed.map<Line>((i) => Line.fromJson(i)).toList();

    return lines;

  }

  Future<List<Car>> fetchCars() async {
    List<Car> cars;
    var response = await http.get('$baseUrl/vehicles');
    cars = (jsonDecode(response.body)['vehicles'] as List).map((i) => Car.fromJson(i)).toList();
    return cars;
  }

  void _refreshState() {
          fetchLines().then((value) {
        setState(() {
          _lines = value; 
          print('loaded lines');
          print(value);
          // update index
          value.map((line) {
            print('LINE INDEX FOR ${line.name}');
            _lineIndex[line.name] = line;
          }).toList();
          print('LINE INDEX');
          print(_lineIndex);


          fetchCars().then((value) {
            setState(() {
              print('loaded buses');
              _cars = value;
              print(value);
              value.map((car) {
                print('next car => $car');
                if (car.line?.isNotEmpty ?? false) {
                  // add car to this line 
                  Line l = _lineIndex[car.line];
                  if (l != null) l.addCar(car);
                  // l.getCars().add(car);
                  print('added $car to $l');
                } else {
                  print('car $car not registered in any line');
                }
              }).toList();

            });
          });

        });
      });

  }

  @override
  void initState() {
    super.initState();
    baseUrl = isProduction ? 'http://projac.mybusway.com:8080' : 'http://10.0.2.2:8080';
    // baseUrl = 'http://projac.mybusway.com:8080';
    print('loading data from server HTTP ${baseUrl}');
    try {
      _refreshState();
    } on Exception catch(e) {
        print('error caught: $e');
      }
    // load lines and buses from the server 

  }

  Future<Null> _refresh() {
    _refreshState();
    print('refresh state');
    return new Future<Null>(() => null);
  }


  @override
  Widget build(BuildContext context) {
    var w = null;
    if (_lines?.isNotEmpty ?? false) {
      w = _lines?.map((l) {
        var x = BusLineCard(l);
        print('NEW BLC => $x');
        return x ;
      })?.toList();
      // print(w);
      // w = Text('a');
    } else {
      w = [Text('LOADING')];
    }
    return RefreshIndicator(key: _refreshIndicatorKey, onRefresh: _refresh, child:SingleChildScrollView(child:Wrap(children: w)));
  }

}