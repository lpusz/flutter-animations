import 'package:flutter/material.dart';

class BoxToHide extends StatelessWidget {
  final double opacity;

  const BoxToHide({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'Hide me',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
