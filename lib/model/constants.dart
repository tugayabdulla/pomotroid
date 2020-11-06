

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

var kModeTitleStyle =  TextStyle(color: Color(0xFFced4e2), fontSize: 24.0);


String formatTime(int time) {
  int minutes = (time / 60).floor();
  int seconds = time % 60;

  var formattedTime = sprintf("%2i : %2i ", [minutes, seconds]);
  return formattedTime;
}