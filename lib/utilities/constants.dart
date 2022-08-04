import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 75.0,
  color: Colors.white,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 25.0,
  color: Colors.white70,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Spartan MB',
  color: Colors.white70,
);

const kConditionTextStyle = TextStyle(
  fontSize: 48.0,
  color: Colors.white70,
);

const kTextBoxDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.place,
    color: Colors.white,
  ),
  hintText: "Enter City Name",
  hintStyle: TextStyle(
    color: Colors.blueGrey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
);
