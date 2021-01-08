import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import './CircleButton.dart';

class StopWidget extends StatefulWidget {

  Map<String, dynamic>stop; 
  StopWidget(this.stop);
  @override
  StopState createState() => new StopState();
}

class StopState extends State<StopWidget> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Center(
        child: Stack(
          children: <Widget>[
            new Positioned(
              child: new CircleButton(onTap: () => {print(widget.stop)}),
              left: widget.stop['left'] ? widget.stop['left'] : 0,
              top: widget.stop['top'] ? widget.stop['top'] : 0,
            )]
        )
      )
    );
  }
}