import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool _isFavorite = false;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

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
      builder: _builder,
    );
  }

  void _initAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.red,
    ).animate(_controller);

    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 40),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40, end: 30),
          weight: 50,
        ),
      ],
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

  Widget _builder(BuildContext context, Widget? _) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: _colorAnimation.value,
        size: _sizeAnimation.value,
      ),
      onPressed: () {
        _isFavorite ? _controller.reverse() : _controller.forward();
      },
    );
  }
}
