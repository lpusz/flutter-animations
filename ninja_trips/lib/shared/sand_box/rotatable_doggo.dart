import 'package:flutter/material.dart';

class RotatableDoggo extends StatefulWidget {
  @override
  State<RotatableDoggo> createState() => _RotatableDoggoState();
}

class _RotatableDoggoState extends State<RotatableDoggo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: Image.asset('images/doggo.jpg'),
      ),
      onTap: () {
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 300)).then((value) {
          _controller.reset();
        });
      },
    );
  }
}
