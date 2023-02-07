import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  DateTime dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    Paint fillBrush = Paint()..color = const Color(0xFF444947);
    canvas.drawCircle(center, radius - 40, fillBrush);

    Paint outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0;
    canvas.drawCircle(center, radius - 40, outlineBrush);

    Paint hrHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    var hrHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hrHandY = centerY +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hrHandX, hrHandY), hrHandBrush);

    Paint minHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader =
          const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerY + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    Paint secHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    var secHandX = centerX + 90 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerY + 90 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    Paint centerFillBrush = Paint()..color = const Color(0xFFEAECFF);
    canvas.drawCircle(center, 16, centerFillBrush);

    Paint dashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    var innerCircle = radius;
    var outerCircle = radius - 16;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircle * cos(i * pi / 180);
      var y1 = centerX + outerCircle * sin(i * pi / 180);

      var x2 = centerX + innerCircle * cos(i * pi / 180);
      var y2 = centerX + innerCircle * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
