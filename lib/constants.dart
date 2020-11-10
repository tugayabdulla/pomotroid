

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var kModeTitleStyle =  TextStyle(color: Color(0xFFced4e2), fontSize: 24.0,fontWeight: FontWeight.bold);


String formatTime(int time) {
  int minutes = (time / 60).floor();
  int seconds = time % 60;

  var f = NumberFormat("00","en-US");
  return f.format(minutes)+":"+f.format(seconds);
}
