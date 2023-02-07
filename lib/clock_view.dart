import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;
  ClockView({Key? key, required this.size}) : super(key: key);

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
      height: widget.size,
      width: widget.size,
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
    canvas.drawCircle(center, radius * 0.75, fillBrush);

    Paint outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    Paint hrHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 28;
    var hrHandX = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hrHandY = centerY +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hrHandX, hrHandY), hrHandBrush);

    Paint minHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader =
          const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 35;
    var minHandX =
        centerX + radius * 0.52 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY =
        centerY + radius * 0.52 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    Paint secHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    var secHandX =
        centerX + radius * 0.64 * cos(dateTime.second * 6 * pi / 180);
    var secHandY =
        centerY + radius * 0.64 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    Paint centerFillBrush = Paint()..color = const Color(0xFFEAECFF);
    canvas.drawCircle(center, 16, centerFillBrush);

    Paint dashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 250;
    var innerCircle = radius;
    var outerCircle = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircle * cos(i * pi / 180);
      var y1 = centerY + outerCircle * sin(i * pi / 180);

      var x2 = centerX + innerCircle * cos(i * pi / 180);
      var y2 = centerY + innerCircle * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
