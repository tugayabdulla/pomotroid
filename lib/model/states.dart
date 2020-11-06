import 'package:flutter/cupertino.dart';

class States extends ChangeNotifier {
  Mode focus = Mode(Color(0xFFFE4E4d), 25,"Focus");
  Mode shortBreak = Mode(Color(0xFF05EB8C), 5, "Short Break");
  Mode longBreak = Mode(Color(0xFF0BBCDA), 15, "Long Break");

  int _tracker = 0;
  void changeFocusDuration(int duration) {
    focus.duration = duration;
  }

  void changeShortBreakDuration(int duration) {
    shortBreak.duration = duration;
  }

  void changeLongBreakDuration(int duration) {
    longBreak.duration = duration;
  }

  finishSetting() {
    notifyListeners();
  }

  Mode getCurrentMode(){
    switch(_tracker%3){
      case 0: return focus;
      case 1: return shortBreak;
      case 2: return longBreak;
    }
    throw Exception("aslfoapsklhgakljngm");
  }

  void changeState(){
    _tracker ++;
    notifyListeners();
  }

}

class Mode {
  Color color;
  int duration;
  String text;
  Mode(this.color, this.duration,this.text);
}
