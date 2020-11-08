import 'package:flutter/cupertino.dart';

class StatesProvider extends ChangeNotifier {
  Mode focus = Mode(Color(0xFFFE4E4d), 25, "Focus");
  Mode shortBreak = Mode(Color(0xFF05EB8C), 5, "Short Break");
  Mode longBreak = Mode(Color(0xFF0BBCDA), 15, "Long Break");

  int _tracker = 0;
  int _rounds = 4;

  List<Mode> tasksList = [
    Mode(Color(0xFFFE4E4d), 25, "Focus"),
    Mode(Color(0xFF05EB8C), 5, "Short Break"),
    Mode(Color(0xFFFE4E4d), 25, "Focus"),
    Mode(Color(0xFF05EB8C), 5, "Short Break"),
    Mode(Color(0xFFFE4E4d), 25, "Focus"),
    Mode(Color(0xFF05EB8C), 5, "Short Break"),
    Mode(Color(0xFFFE4E4d), 25, "Focus"),
    Mode(Color(0xFF05EB8C), 5, "Short Break"),
    Mode(Color(0xFF0BBCDA), 15, "Long Break"),
  ];

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

  changeRoundCount(int round) {
    _rounds = round;
    tasksList = [];
    for (int i = 0; i < round; i++) {
      tasksList.add(focus);
      tasksList.add(shortBreak);
    }
    tasksList.add(longBreak);
  }

  int get rounds => _rounds;

  int get currentRound {
    if (_tracker == 2 * _rounds) {
      return (_tracker / 2).floor();
    }
    return (_tracker / 2).floor() + 1;
  }

  Mode getCurrentMode() => tasksList[_tracker];

  void changeMode() {
    if (_tracker == 2 * _rounds) {
      _tracker = -1;
    }
    _tracker++;
    notifyListeners();
  }

  void reset() {
    _tracker = 0;
    notifyListeners();
  }
}



class Mode {
  Color color;
  int duration;
  String text;

  Mode(this.color, this.duration, this.text);
}
