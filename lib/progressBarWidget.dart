import 'dart:math';

import 'package:custom_progress_bar/progressBarPainter.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget(
      {Key? key,
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
      this.duration = const Duration(seconds: 10),
      this.shadowEffectColor = Colors.grey,
      this.progressValue = 100,
      this.curve = Curves.linear})
      : super(key: key);
  final Curve curve;
  final Color shadowEffectColor;
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
  final Duration duration;
  final double progressValue;

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // The logic of using animation controller in the same class is that to decrease complexity for user
    //If i make the seprated widget for this animation , the code is obiously more organized but let me explain the drawbacks
    //////////////////DrawBacks/////////////////
    //If i made seprated widget and set required for child  then user have to give the Animation  class and progress widget as its child
    //This will increase complexity
    //You will be thinking i can do it my self by making animation widget parent of all widget here , in this way user don't have to give by himself
    //I have tried this but then i will not get the animation object
    // The animation object is needed for doing animation in ProgressBarPainter
    //I hope so you understand why i do this
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addListener(() {
            setState(() {});
          });
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    if (widget.isClickedOnbar) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startAnimation() {
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        startAnimation();
      },
      child: CustomPaint(
        size: widget.size,
        painter: ProgressBarPainter(
            curve: widget.curve,
            shadowEffectColor: widget.shadowEffectColor,
            animation: _animation,
            isClicked: widget.isClickedOnbar,
            gradientColors: widget.gradientColors,
            textFontSize: widget.textFontSize,
            textFontStyle: widget.textFontStyle,
            textFontWeight: widget.textFontWeight,
            startAngle: widget.startAngle,
            isUseGradient: widget.isUseGradient,
            progressBarColor: widget.progressBarColor,
            activeBorders: widget.activeBorders,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            progressBarWidth: widget.progressBarWidth,
            size: widget.size,
            onTap: widget.onTap,
            isClickedOnbar: widget.isClickedOnbar,
            progressValue: widget.progressValue),
      ),
    );
  }
}
