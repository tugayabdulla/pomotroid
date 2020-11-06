import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomotroid/model/states.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

class CountdownIndicator extends StatelessWidget {
  const CountdownIndicator(
      {@required this.timeLeft});

  final int timeLeft;


  String formatTime() {
    int minutes = (timeLeft / 60).floor();
    int seconds = timeLeft % 60;

    var time = sprintf("%2i : %2i ", [minutes, seconds]);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (_, a, child) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.all(15.0),
            child: CustomPaint(
              painter: Progress(a.getCurrentMode().color, timeLeft / a.getCurrentMode().duration),
            ),
          ),
          Text(
            formatTime(),
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
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
