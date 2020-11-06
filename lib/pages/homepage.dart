import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomotroid/model/states.dart';
import 'package:pomotroid/pages/settings.dart';
import 'package:pomotroid/widgets/countdown_indicator.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer _timer;

  int timeLeft = 25;
  bool isPaused = true;

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => setState(
        () {
          timeLeft--;
          if (timeLeft == 0) {
            Provider.of<States>(context, listen: false).changeState();
            timeLeft = Provider.of<States>(context, listen: false)
                .getCurrentMode()
                .duration;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // startTimer();
    super.initState();
  }

  _onButtonClicked() {
    if (isPaused) {
      startTimer();
    } else {
      _timer.cancel();
    }
    isPaused = !isPaused;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff2f384b),
        appBar: AppBar(actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Settings()));
          })
        ],),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: CountdownIndicator(timeLeft: timeLeft),
              ),
              Expanded(
                flex: 2,
                child: MaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(
                      side: BorderSide(
                          width: 2,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  child: Icon(
                    isPaused ? Icons.play_arrow : Icons.pause,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _onButtonClicked();
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
