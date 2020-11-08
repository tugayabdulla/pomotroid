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
  StatesProvider statesProvider;

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => setState(
        () {
          timeLeft--;
          if (timeLeft == 0) {
            statesProvider.changeMode();
            timeLeft = statesProvider.getCurrentMode().duration;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    statesProvider = Provider.of<StatesProvider>(context, listen: false);
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
    print('build');
    return Scaffold(
        backgroundColor: Color(0xff2f384b),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Settings()));
                })
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 10,
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
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${statesProvider.currentRound}/${statesProvider.rounds}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                statesProvider.reset();
                                timeLeft = statesProvider.focus.duration;
                                isPaused = false;
                                _onButtonClicked();
                              });
                            },
                            child: Text(
                              "Reset",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          )
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.skip_next_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            setState(() {
                              statesProvider.changeMode();
                              timeLeft =
                                  statesProvider.getCurrentMode().duration;
                            });
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
