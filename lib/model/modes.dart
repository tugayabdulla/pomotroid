import 'dart:async';

import 'package:flutter/cupertino.dart';

const DEFAULT_ROUND = 4;
const DEFAULT_FOCUS_DURATION = 25;
const DEFAULT_SHORT_BREAK_DURATION = 5;
const DEFAULT_LONG_BREAK_DURATION = 15;

class ModesProvider extends ChangeNotifier {
  Mode focus = Mode(Color(0xFFFE4E4d), DEFAULT_FOCUS_DURATION, "Focus");
  Mode shortBreak =
      Mode(Color(0xFF05EB8C), DEFAULT_SHORT_BREAK_DURATION, "Short Break");
  Mode longBreak =
      Mode(Color(0xFF0BBCDA), DEFAULT_LONG_BREAK_DURATION, "Long Break");

  int _tracker = 0;
  int _rounds = DEFAULT_ROUND;
  Timer _timer;
  int timeLeft = DEFAULT_FOCUS_DURATION;

  List<Mode> _modesList;

  ModesProvider() {
    renewModesList();
  }

  onButtonClicked() {
    isPaused ? startTimer() : cancelTimer();
  }

  bool get isPaused => _timer == null || !_timer.isActive;

  int get rounds => _rounds;

  void changeFocusDuration(int duration) => focus.duration = duration;

  void changeShortBreakDuration(int duration) => shortBreak.duration = duration;

  void changeLongBreakDuration(int duration) => longBreak.duration = duration;

  changeRoundCount(int round) => _rounds = round;

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
    renewModesList();
    resetProgress();
  }

  renewModesList() {
    _modesList = [];

    for (int i = 0; i < _rounds; i++) {
      _modesList.add(focus);
      _modesList.add(shortBreak);
    }
    _modesList.add(longBreak);
  }

  int get currentRound => _tracker == 2 * _rounds
      ? (_tracker / 2).floor()
      : (_tracker / 2).floor() + 1;

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
    cancelTimer();
    _tracker = 0;
    timeLeft = focus.duration;
    notifyListeners();
  }

  void resetSettings() {
    _tracker = 0;
    _rounds = 4;
    cancelTimer();

    focus.duration = DEFAULT_FOCUS_DURATION;
    shortBreak.duration = DEFAULT_SHORT_BREAK_DURATION;
    longBreak.duration = DEFAULT_LONG_BREAK_DURATION;
// TODO
    notifyListeners();
  }
}

class Mode {
  Color color;
  int duration;
  String text;

  Mode(this.color, this.duration, this.text);
}
