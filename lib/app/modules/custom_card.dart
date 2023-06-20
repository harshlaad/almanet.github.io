import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.04266667, size.height * 0.1918819);
    path_0.cubicTo(
        size.width * 0.04266667,
        size.height * 0.1266675,
        size.width * 0.08087173,
        size.height * 0.07380074,
        size.width * 0.1280000,
        size.height * 0.07380074);
    path_0.lineTo(size.width * 0.8746667, size.height * 0.07380074);
    path_0.cubicTo(
        size.width * 0.9217947,
        size.height * 0.07380074,
        size.width * 0.9600000,
        size.height * 0.1266675,
        size.width * 0.9600000,
        size.height * 0.1918819);
    path_0.lineTo(size.width * 0.9600000, size.height * 0.4852399);
    path_0.cubicTo(
        size.width * 0.9600000,
        size.height * 0.5504539,
        size.width * 0.9217947,
        size.height * 0.6033210,
        size.width * 0.8746667,
        size.height * 0.6033210);
    path_0.lineTo(size.width * 0.7400000, size.height * 0.6033210);
    path_0.cubicTo(
        size.width * 0.7090720,
        size.height * 0.6033210,
        size.width * 0.6840000,
        size.height * 0.6380148,
        size.width * 0.6840000,
        size.height * 0.6808118);
    path_0.lineTo(size.width * 0.6840000, size.height * 0.7638376);
    path_0.cubicTo(
        size.width * 0.6840000,
        size.height * 0.8290517,
        size.width * 0.6457947,
        size.height * 0.8819188,
        size.width * 0.5986667,
        size.height * 0.8819188);
    path_0.lineTo(size.width * 0.1280000, size.height * 0.8819188);
    path_0.cubicTo(
        size.width * 0.08087173,
        size.height * 0.8819188,
        size.width * 0.04266667,
        size.height * 0.8290517,
        size.width * 0.04266667,
        size.height * 0.7638376);
    path_0.lineTo(size.width * 0.04266667, size.height * 0.1918819);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.04266667, size.height * 0.1918819);
    path_1.cubicTo(
        size.width * 0.04266667,
        size.height * 0.1266675,
        size.width * 0.08087173,
        size.height * 0.07380074,
        size.width * 0.1280000,
        size.height * 0.07380074);
    path_1.lineTo(size.width * 0.8746667, size.height * 0.07380074);
    path_1.cubicTo(
        size.width * 0.9217947,
        size.height * 0.07380074,
        size.width * 0.9600000,
        size.height * 0.1266675,
        size.width * 0.9600000,
        size.height * 0.1918819);
    path_1.lineTo(size.width * 0.9600000, size.height * 0.4852399);
    path_1.cubicTo(
        size.width * 0.9600000,
        size.height * 0.5504539,
        size.width * 0.9217947,
        size.height * 0.6033210,
        size.width * 0.8746667,
        size.height * 0.6033210);
    path_1.lineTo(size.width * 0.7400000, size.height * 0.6033210);
    path_1.cubicTo(
        size.width * 0.7090720,
        size.height * 0.6033210,
        size.width * 0.6840000,
        size.height * 0.6380148,
        size.width * 0.6840000,
        size.height * 0.6808118);
    path_1.lineTo(size.width * 0.6840000, size.height * 0.7638376);
    path_1.cubicTo(
        size.width * 0.6840000,
        size.height * 0.8290517,
        size.width * 0.6457947,
        size.height * 0.8819188,
        size.width * 0.5986667,
        size.height * 0.8819188);
    path_1.lineTo(size.width * 0.1280000, size.height * 0.8819188);
    path_1.cubicTo(
        size.width * 0.08087173,
        size.height * 0.8819188,
        size.width * 0.04266667,
        size.height * 0.8290517,
        size.width * 0.04266667,
        size.height * 0.7638376);
    path_1.lineTo(size.width * 0.04266667, size.height * 0.1918819);
    path_1.close();

    Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint1Stroke.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_1, paint1Stroke);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0x0fffffff).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
