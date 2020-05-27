import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BackgroundPaint extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size){
    final paint = Paint();
    paint.style = PaintingStyle.fill;

    Path path = Path();

    //offsets
    Offset bottomLeft = Offset(0, size.height/2 + 10.0);
    Offset bottomRight = Offset(size.width, size.height/2);
    Offset topRight = Offset(size.width, 0);

    Offset firstControlPoint = Offset(size.width/4, size.height/1.5);
    Offset firstEndPoint = Offset(size.width/2, size.height/2);
    Offset secondControlPoint = Offset(size.width/1.5, size.height/2.5);
    Offset secondEndPoint = Offset(size.width, size.height/2 + 10.0);

    path.lineTo(bottomLeft.dx, bottomLeft.dy);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(bottomRight.dx, bottomRight.dy);
    path.lineTo(topRight.dx, topRight.dy);
    path.close();

    paint.shader = ui.Gradient.linear(bottomLeft, topRight, [Colors.blue, Colors.lightBlueAccent]);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}