import 'dart:async';

import 'package:flutter/cupertino.dart';




class ModesProvider extends ChangeNotifier {
  Mode focus = Mode(Color(0xFFFE4E4d), 25, "Focus");
  Mode shortBreak = Mode(Color(0xFF05EB8C), 5, "Short Break");
  Mode longBreak = Mode(Color(0xFF0BBCDA), 15, "Long Break");

  int _tracker = 0;
  int _rounds = 4;
  Timer _timer;
  int timeLeft = 25;
  int a;

  ModesProvider() {
    changeRoundCount(4);
  }

  List<Mode> _modesList;

  void changeFocusDuration(int duration) => focus.duration = duration;

  void changeShortBreakDuration(int duration) => shortBreak.duration = duration;

  void changeLongBreakDuration(int duration) => longBreak.duration = duration;

  set longBreakDuration(int duration) => longBreak.duration = duration;

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        timeLeft--;
        if (timeLeft == 0) {
          changeMode();
          timeLeft = currentMode.duration;
        }
        notifyListeners();
      },
    );
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  finishSetting() {
    _tracker = 0;
    changeRoundCount(rounds);
    notifyListeners();
  }

  changeRoundCount(int round) {
    _rounds = round;
    _modesList = [];
    for (int i = 0; i < round; i++) {
      _modesList.add(focus);
      _modesList.add(shortBreak);
    }
    _modesList.add(longBreak);
  }

  int get rounds => _rounds;

  int get currentRound {
    if (_tracker == 2 * _rounds) {
      return (_tracker / 2).floor();
    }
    return (_tracker / 2).floor() + 1;
  }

  get currentMode => _modesList[_tracker];

  void changeMode() {
    if (_tracker == 2 * _rounds) {
      _tracker = -1;
    }
    _tracker++;
    timeLeft = _modesList[_tracker].duration;
    cancelTimer();
    startTimer();
    notifyListeners();
  }

  void resetProgress() {
    _tracker = 0;
    timeLeft = focus.duration;
    notifyListeners();
  }

  void resetSettings() {
    _tracker = 0;
    changeRoundCount(4);
    _rounds = 4;
    focus.duration = 25;
    shortBreak.duration = 5;
    longBreak.duration = 15;

    notifyListeners();
  }
}

class Mode {
  Color color;
  int duration;
  String text;

  Mode(this.color, this.duration, this.text);
}
