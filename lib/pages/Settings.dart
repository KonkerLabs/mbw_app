import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    developer.log('context info', error: context);
    return Container(
      padding: EdgeInsets.all(0),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
                Form.of(primaryFocus.context).save();
              },
        child: Wrap(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'server',
                labelText: 'MyBusWay API server'
              ),
              onSaved: (String value) {
                developer.log('o que escreveu', error: value);
              }
            )
          ],
        )
      )

    );
  }

}