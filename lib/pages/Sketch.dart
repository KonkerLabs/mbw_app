import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overlay_screen/overlay_screen.dart';

class SketchPage extends StatefulWidget {
  SketchState createState() => new SketchState();
}


class SketchState extends State<SketchPage> {

  List _lineStates = [false, false, false, false];

  void _toggleState(id) {
    setState(() {
      _lineStates[id] = !_lineStates[id];
      print("line $id state = ${_lineStates[id]}");
    });
  }

  bool _isLineVisible() {
    bool r =  _lineStates.reduce((value, element) => element || value);
    print("is there any line toggled ? $r");
    return r;
  }

  @override
  Widget build(BuildContext context) {

    

    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            RaisedButton(child: Column(children: [Image(image: AssetImage("images/symbol-yellow.png"), width: 50,), Text("Amarela")],), autofocus: false, onPressed:() {_toggleState(0);}),
            RaisedButton(child: Column(children: [Image(image: AssetImage("images/symbol-green.png"), width: 50), Text("Verde")],), autofocus: false, onPressed:() {_toggleState(1);}),
            RaisedButton(child: Column(children: [Image(image: AssetImage("images/symbol-pink.png"), width: 50), Text("Rosa")],), autofocus: false, onPressed:() {_toggleState(2);}),
            RaisedButton(child: Column(children: [Image(image: AssetImage("images/symbol-blue.png"), width: 50), Text("Azul")],), autofocus: false, onPressed:() {_toggleState(3);}),
          ]), // photo
          Expanded(child: ClipRect(child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(5.0),
            child: Stack(
              children: [
                new Container(
                  decoration: new BoxDecoration(
                    color: Colors.white, 
                    image: new DecorationImage(
                      colorFilter: _isLineVisible() ? new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop) : null,
                      // fit: BoxFit.cover, 
                      image: AssetImage("images/base-rotas-white.png")
                    )
                  ), 
                  child: 
                    // new Image(image: AssetImage("images/base-rotas-white.png"), )
                    new Container()
                  // 
                ),
                // new Image(fit: BoxFit.cover, image: AssetImage("images/base-rotas-white.png")),
                _lineStates[0]  ? new Container(decoration: new BoxDecoration(image: new DecorationImage(image: AssetImage("images/line-yellow.png"))), child: new Container()) : new Container(),
                _lineStates[1]  ? new Container(decoration: new BoxDecoration(image: new DecorationImage(image: AssetImage("images/line-green.png"))), child: new Container()) : new Container(),
                _lineStates[2]  ? new Container(decoration: new BoxDecoration(image: new DecorationImage(image: AssetImage("images/line-pink.png"))), child: new Container()) : new Container(),
                _lineStates[3]  ? new Container(decoration: new BoxDecoration(image: new DecorationImage(image: AssetImage("images/line-blue.png"))), child: new Container()) : new Container(),
              ]), 
            minScale: 0.2, 
            maxScale: 4,)
            ),
          ),          
        ])
    );
  }

}