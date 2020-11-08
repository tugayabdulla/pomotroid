import 'package:flutter/material.dart';
import 'package:pomotroid/model/constants.dart';
import 'package:pomotroid/model/states.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Mode focus;
  Mode shortBreak;
  Mode longBreak;

  int rounds;

  int focusDuration, shortBreakDuration, longBreakDuration;
  StatesProvider states;

  @override
  void initState() {

    states =  Provider.of<StatesProvider>(context, listen: false);
    focus = states.focus;
    shortBreak = states.shortBreak;
    longBreak = states.longBreak;
    rounds = states.rounds;

    focusDuration = focus.duration;
    shortBreakDuration = shortBreak.duration;
    longBreakDuration = longBreak.duration;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      backgroundColor: Color(0xff2f384b),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Color(0xFF3d4457),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              focus.text,
              style: kModeTitleStyle,
            )),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(0xff2f384b),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  formatTime(focusDuration),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: focusDuration.toDouble(),
              onChanged: (value) {
                setState(() {
                  focusDuration = value.toInt();
                });
              },

              min: 1,
              max: 90,
              activeColor: focus.color,
              inactiveColor: Color(0xff2f384b),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              shortBreak.text,
              style: kModeTitleStyle,
            )),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(0xff2f384b),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  formatTime(shortBreakDuration),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: shortBreakDuration.toDouble(),
              onChanged: (value) {
                setState(() {
                  shortBreakDuration = value.toInt();
                });
              },
              min: 1,
              max: 90,
              activeColor: shortBreak.color,
              inactiveColor: Color(0xff2f384b),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              longBreak.text,
              style: kModeTitleStyle,
            )),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(0xff2f384b),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  formatTime(longBreakDuration),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: longBreakDuration.toDouble(),
              onChanged: (value) {
                setState(() {
                  longBreakDuration = value.toInt();
                });
              },
              min: 1,
              max: 90,
              activeColor: longBreak.color,
              inactiveColor: Color(0xff2f384b),
            ), SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "Rounds",
              style: kModeTitleStyle,
            )),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(0xff2f384b),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  rounds.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: rounds.toDouble(),
              onChanged: (value) {
                setState(() {
                  rounds = value.toInt();
                });
              },
              min: 1,
              max: 10,
              activeColor: Color(0xFF9ba4b4),
              inactiveColor: Color(0xff2f384b),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {


    super.dispose();
  }
  @override
  void deactivate() {
    states.changeFocusDuration(focusDuration);
    states.changeShortBreakDuration(shortBreakDuration);
    states.changeLongBreakDuration(longBreakDuration);

    states.finishSetting();
    super.deactivate();
  }
}
