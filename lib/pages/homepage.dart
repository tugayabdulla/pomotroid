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

  bool isPaused = true;

  @override
  void initState() {
    super.initState();
  }

  _onButtonClicked(ModesProvider provider) {
    if (isPaused) {
      provider.startTimer();
    } else {
      provider.cancelTimer();
    }
    isPaused = !isPaused;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModesProvider>(
      builder: (context, value, child) {

        return Scaffold(
            backgroundColor: Color(0xff2f384b),
            appBar: AppBar(
              elevation: 0,
              title: Text('Pomotroid'),
              actions: [
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () async {
                      var isChanged = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Settings()));
                      if (isChanged) {
                        print("changed");
                        setState(() {

                          value.cancelTimer();
                          isPaused = true;
                          value.resetProgress();

                        });
                      }
                    })
              ],
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 10,
                    child: CountdownIndicator(),
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
                          _onButtonClicked(value);
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
                                "${value.currentRound}/${value.rounds}",
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
                                    value.resetProgress();

                                    isPaused = false;
                                    _onButtonClicked(value);
                                  });
                                },
                                child: Text(
                                  "Reset",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
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
                                  value.changeMode();
                                });
                              })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
