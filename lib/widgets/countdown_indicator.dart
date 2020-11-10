import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomotroid/model/states.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CountdownIndicator extends StatelessWidget {
  const CountdownIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModesProvider>(builder: (_, a, child) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.width / 1.5,
            margin: EdgeInsets.all(15.0),
            child: CustomPaint(
              painter: Progress(
                  a.currentMode.color, a.timeLeft / a.currentMode.duration),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatTime(a.timeLeft),
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                a.currentMode.text.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ],
          )
        ],
      );
    });
  }
}

class Progress extends CustomPainter {
  Color color;
  double progress;

  Progress(this.color, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.rotate(-pi / 2);

    var width = size.width;
    var height = size.height;

    var radius = width / 2;
    var center = Offset(-height / 2, width / 2);

    var backPaint = Paint()
      ..color = Color(0xFF9ba4b4)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backPaint);

    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
    Rect rect =
        Rect.fromCenter(center: center, height: radius * 2, width: radius * 2);
    canvas.drawArc(rect, 0, progress * 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
