import 'package:flutter/material.dart';

class PieselImage extends StatelessWidget {
  final Animation<int> pieselSizeAnimation;

  const PieselImage({
    super.key,
    required this.pieselSizeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final value = pieselSizeAnimation.value;
    final valueAsDouble = value.toDouble();

    return Image.asset(
      'images/piesel.jpg',
      height: valueAsDouble,
      width: valueAsDouble,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}
