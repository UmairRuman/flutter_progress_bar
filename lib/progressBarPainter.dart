import 'dart:math';

import 'package:flutter/material.dart';

class ProgressBarPainter extends CustomPainter {
  const ProgressBarPainter(
      {required this.animation,
      required this.isClicked,
      required this.size,
      this.gradientColors = const [
        Colors.purple,
        Colors.green,
        Colors.yellow,
        Colors.pink,
      ],
      this.textFontSize = 25,
      this.textFontStyle = FontStyle.normal,
      this.textFontWeight = FontWeight.bold,
      this.startAngle = -pi / 2,
      this.isUseGradient = false,
      this.progressBarColor = Colors.blue,
      this.activeBorders = false,
      this.borderColor = Colors.grey,
      this.borderWidth = 20,
      this.progressBarWidth = 10,
      required this.onTap,
      required this.isClickedOnbar,
      required this.shadowEffectColor});
  final Color shadowEffectColor;
  final Animation<double> animation;
  final bool isClicked;
  final Size size;
  final List<MaterialColor> gradientColors;
  final double textFontSize;
  final FontStyle textFontStyle;
  final FontWeight textFontWeight;
  final double startAngle;
  final bool isUseGradient;
  final Color progressBarColor;
  final bool activeBorders;
  final Color borderColor;
  final double borderWidth;
  final double progressBarWidth;
  final VoidCallback onTap;
  final bool isClickedOnbar;
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerWidth = width / 2;
    final centerHeight = height / 2;
    final radius = min(width, height) / 2;

    //Paint for Border of Progress Bar

    final paintForProgressBarOuterBorder = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    //Draw Circle for Border
    if (activeBorders) {
      canvas.drawCircle(Offset(centerWidth, centerHeight), radius,
          paintForProgressBarOuterBorder);
    }
    //Paint for Shadow efffect
    final paintForShadowEffect = Paint()
      ..color = shadowEffectColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressBarWidth;

    //Draw Circle for shadow Border
    canvas.drawCircle(
        Offset(centerWidth, centerHeight), radius, paintForShadowEffect);

    //Paint For drawing Circle Of Progress Bar
    final paintForProgressBar = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressBarWidth;

    // If the isUseGrradient is set true then the gradient will show
    if (isUseGradient) {
      paintForProgressBar.shader = LinearGradient(
        colors: gradientColors,
      ).createShader(
        Rect.fromCircle(
          center: Offset(centerWidth, centerHeight),
          radius: radius,
        ),
      );
    } else {
      paintForProgressBar.color = progressBarColor ?? progressBarColor;
    }
    //Is clicked is true when the user clicked on Progress bar
    if (isClicked) {
      //Arc for progress Bar
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(centerWidth, centerHeight),
          radius: radius,
        ),
        startAngle,
        2 * pi * animation.value,
        false,
        paintForProgressBar,
      );
      //Write Text inside the progress bar
      int text = (animation.value * 100).toInt();
      TextSpan textSpan = TextSpan(
          text: "$text% ",
          style: TextStyle(
              color: Colors.black,
              fontSize: textFontSize,
              fontWeight: textFontWeight));
      //Painter Object
      TextPainter textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();
      //Calculate width and height to subtract the half of it , so the text will be at center
      final textWidth = textPainter.width;
      final textHeight = textPainter.height;
      textPainter.paint(canvas,
          Offset(centerWidth - textWidth / 2, centerHeight - textHeight / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
