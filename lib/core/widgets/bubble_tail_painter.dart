import 'package:flutter/material.dart';

class BubbleTailPainter extends CustomPainter {
  final Color color;
  final bool isLeft;

  BubbleTailPainter({required this.color, required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isLeft) {
      // 왼쪽 아래 꼬리
      path.moveTo(0, 10);
      path.lineTo(10, 0);
      path.lineTo(10, 20);
    } else {
      // 오른쪽 아래 꼬리
      path.moveTo(10, 10);
      path.lineTo(0, 0);
      path.lineTo(0, 20);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
