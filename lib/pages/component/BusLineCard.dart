import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../model/Line.dart';
import '../model/Car.dart';

class BusLineCard extends StatefulWidget {

  Line line;

  BusLineCard(this.line);

  @override
  BusLineState createState() => new BusLineState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BLC(line=${line.name})';
  }

}

class BusLineState extends State<BusLineCard> {

  @override
  Widget build(Object context) {
    final f = new NumberFormat("###.0000");

    return Container(
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      height: 200,
      child:SizedBox(
        height: double.infinity,
        child: Card(
          elevation: 2, 
          child: Row(children: [
            Container(child:Column(children: [
              Image(image:AssetImage('images/symbol-${widget.line.color}.png')),
              Text(widget.line.name),
              Expanded(child:DataTable(
                columns: [DataColumn(label: Text('name')), DataColumn(label:Text('lat')), DataColumn(label:Text('long'))],
                rows:widget.line.stops.map<DataRow>((stop) => DataRow(cells:[
                  DataCell(Text(stop["name"])), 
                  DataCell(Text(f.format(stop["lat"]))),
                  DataCell(Text(f.format(stop["long"])))
                ])).toList()))
            ],)),
          ],)
        )
      ));
  }

}