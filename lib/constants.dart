

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


const ROUND_KEY = "round";
const FOCUS_DURATION_KEY = "focus";
const SHORT_BREAK_DURATION_KEY = "short_break";
const LONG_BREAK_DURATION_KEY = "long_break";

const DEFAULT_ROUND = 4;
const DEFAULT_FOCUS_DURATION = 25*60;
const DEFAULT_SHORT_BREAK_DURATION = 5*60;
const DEFAULT_LONG_BREAK_DURATION = 15*60;

var kModeTitleStyle =  TextStyle(color: Color(0xFFced4e2), fontSize: 24.0,fontWeight: FontWeight.bold);


String formatTime(int time) {
  int minutes = (time / 60).floor();
  int seconds = time % 60;

  var f = NumberFormat("00","en-US");
  return f.format(minutes)+":"+f.format(seconds);
}
