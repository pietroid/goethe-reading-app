import 'package:flutter/material.dart';

class IndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff959595);
    path = Path();
    path.lineTo(0, size.height * 0.53);
    path.cubicTo(0, size.height * 0.53, size.width, size.height * 0.03,
        size.width, size.height * 0.03);
    path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 1.03,
        size.width, size.height * 1.03);
    path.cubicTo(size.width, size.height * 1.03, 0, size.height * 0.53, 0,
        size.height * 0.53);
    path.cubicTo(
        0, size.height * 0.53, 0, size.height * 0.53, 0, size.height * 0.53);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 30,
        height: 30,
        child: CustomPaint(
          painter: IndicatorPainter(),
        ));
  }
}
