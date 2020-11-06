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

  int focusDuration, shortBreakDuration, longBreakDuration;

  @override
  void initState() {
    focus = Provider.of<States>(context, listen: false).focus;
    shortBreak = Provider.of<States>(context, listen: false).shortBreak;
    longBreak = Provider.of<States>(context, listen: false).longBreak;

    focusDuration = focus.duration;
    shortBreakDuration = shortBreak.duration;
    longBreakDuration = longBreak.duration;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              inactiveColor:  Color(0xff2f384b),

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
              inactiveColor:  Color(0xff2f384b),

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
              inactiveColor:  Color(0xff2f384b),

            )
          ],
        ),
      ),
    );
  }
}
