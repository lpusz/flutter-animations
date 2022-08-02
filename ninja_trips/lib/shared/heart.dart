import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool _isFavorite = false;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _controller.addStatusListener(_controllerStatusListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (BuildContext context, Widget? _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: 30,
          ),
          onPressed: () {
            _isFavorite ? _controller.reverse() : _controller.forward();
          },
        );
      },
    );
  }

  void _initAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.red,
    ).animate(_controller);
  }

  void _controllerStatusListener(status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _isFavorite = true;
      });
    } else if (status == AnimationStatus.dismissed) {
      setState(() {
        _isFavorite = false;
      });
    }
  }
}
