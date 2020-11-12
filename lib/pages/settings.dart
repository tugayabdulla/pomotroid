import 'package:flutter/material.dart';
import 'package:pomotroid/model/modes.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Mode focus;
  Mode shortBreak;
  Mode longBreak;

  bool changed = false;

  // int focusDuration, shortBreakDuration, longBreakDuration;
  ModesProvider provider;

  @override
  void initState() {
    provider = Provider.of<ModesProvider>(context, listen: false);
    focus = provider.focus;
    shortBreak = provider.shortBreak;
    longBreak = provider.longBreak;
    //
    // focusDuration = focus.duration;
    // shortBreakDuration = shortBreak.duration;
    // longBreakDuration = longBreak.duration;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, changed),
        ),
        title: Text("Settings"),
      ),
      backgroundColor: Color(0xff2f384b),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
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
                  formatTime(focus.duration),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: focus.duration/60,
              onChanged: (value) {
                setState(() {
                  changed = true;
                  provider.focusDuration = value.toInt()*60;
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
                  formatTime(shortBreak.duration),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: shortBreak.duration/60,
              onChanged: (value) {
                setState(() {
                  changed = true;
                  provider.shortBreakDuration = value.toInt()*60;
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
                  formatTime(longBreak.duration),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: longBreak.duration/60,
              onChanged: (value) {
                setState(() {
                  changed = true;
                  provider.longBreakDuration = value.toInt()*60;
                });
              },
              min: 1,
              max: 90,
              activeColor: longBreak.color,
              inactiveColor: Color(0xff2f384b),
            ),
            SizedBox(
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
                  provider.rounds.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Slider(
              value: provider.rounds.toDouble(),
              onChanged: (value) {
                setState(() {
                  changed = true;
                  provider.roundCount = value.toInt();
                });
              },
              min: 1,
              max: 10,
              activeColor: Color(0xFF9ba4b4),
              inactiveColor: Color(0xff2f384b),
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
                onPressed: () {
                  provider.resetSettings();
                  setState(() {});
                },
                child: Text(
                  'Reset to Default',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ))
          ],
        ),
      ),
    );
  }
}
