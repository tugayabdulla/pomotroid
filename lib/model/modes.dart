import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../constants.dart';

class ModesProvider extends ChangeNotifier {
  Mode focus;
  Mode shortBreak;
  Mode longBreak;
  int _rounds;

  int _tracker = 0;

  Timer _timer;
  int timeLeft = DEFAULT_FOCUS_DURATION;

  List<Mode> _modesList;

  ModesProvider() {
    focus = Mode(Color(0xFFFE4E4d), DEFAULT_FOCUS_DURATION, "Focus");
    shortBreak =
        Mode(Color(0xFF05EB8C), DEFAULT_SHORT_BREAK_DURATION, "Short Break");
    longBreak =
        Mode(Color(0xFF0BBCDA), DEFAULT_LONG_BREAK_DURATION, "Long Break");
    _rounds = DEFAULT_ROUND;
    renewModesList();
  }

  ModesProvider.fromSharedPrefs(int round, int focusDuration,
      int shortBreakDuration, int longBreakDuration) {
    focus = Mode(Color(0xFFFE4E4d), focusDuration, "Focus");
    shortBreak = Mode(Color(0xFF05EB8C), shortBreakDuration, "Short Break");
    longBreak = Mode(Color(0xFF0BBCDA), longBreakDuration, "Long Break");
    _rounds = round;
    renewModesList();
  }

  onButtonClicked() => isPaused ? startTimer() : cancelTimer();

  bool get isPaused => _timer == null || !_timer.isActive;

  int get rounds => _rounds;

  set focusDuration(int duration) => focus.duration = duration;

  set shortBreakDuration(int duration) => shortBreak.duration = duration;

  set longBreakDuration(int duration) => longBreak.duration = duration;

  set roundCount(int round) => _rounds = round;

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
    _rounds = DEFAULT_ROUND;
    cancelTimer();

    focus.duration = DEFAULT_FOCUS_DURATION;
    shortBreak.duration = DEFAULT_SHORT_BREAK_DURATION;
    longBreak.duration = DEFAULT_LONG_BREAK_DURATION;
  }
}

class Mode {
  Color color;
  int duration;
  String text;

  Mode(this.color, this.duration, this.text);
}
