import 'package:flutter/material.dart';

class AnimatedCurtain extends StatelessWidget {
  final bool showMessage;
  final Duration duration;
  final double width;
  final double height;
  final Color startColor;
  final Color endColor;

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  const AnimatedCurtain({
    super.key,
    required this.showMessage,
    required this.duration,
    required this.width,
    required this.height,
    required this.startColor,
    required this.endColor,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    final color = !showMessage ? startColor : endColor;
    return AnimatedPositioned(
      child: AnimatedContainer(
        width: width,
        height: height,
        color: color,
        duration: duration,
      ),
      duration: duration,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }
}
