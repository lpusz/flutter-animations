import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninja_trips/shared/sand_box/animated_curtain.dart';
import 'package:ninja_trips/shared/sand_box/piesel_image.dart';
import 'package:ninja_trips/shared/sand_box/rotatable_doggo.dart';
import 'package:ninja_trips/shared/sand_box/tween_sequences.dart';

class AnimationSandBox extends StatefulWidget {
  const AnimationSandBox({Key? key}) : super(key: key);

  @override
  State<AnimationSandBox> createState() => _AnimationSandBoxState();
}

class _AnimationSandBoxState extends State<AnimationSandBox>
    with TickerProviderStateMixin {
  bool showMessage = false;

  final Duration _animationDuration = Duration(seconds: 3);
  final Duration _boxDuration = Duration(seconds: 3);

  late AnimationController _controller;
  late AnimationController _spinningController;

  late Animation<double> _curve;
  late Animation<double> _spinningCurve;
  late Animation<int> _bounceBoxAnimation;
  late Animation<double> _verticalAnimation;
  late Animation<int> _pieselSizeAnimation;

  @override
  void initState() {
    super.initState();
    initAnimationControllers();
    initCurves();

    _bounceBoxAnimation = bounceBoxSequence.animate(_curve);
    _pieselSizeAnimation = pieselSizeSequence.animate(_curve);
    _verticalAnimation = Tween<double>(begin: 0, end: 0).animate(_curve);
  }

  void initAnimationControllers() {
    _controller = AnimationController(
      duration: _boxDuration,
      vsync: this,
    );
    _spinningController = AnimationController(
      duration: _boxDuration,
      vsync: this,
    );
  }

  void initCurves() {
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    _spinningCurve = CurvedAnimation(
      parent: _spinningController,
      curve: Curves.linear,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _verticalAnimation = Tween<double>(
        begin: 0,
        end: MediaQuery.of(context).size.height - 130,
      ).animate(_curve);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _spinningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Sand box'),
        actions: [
          IconButton(
            onPressed: startAnimation,
            icon: Icon(Icons.play_circle_fill_outlined),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RotatableDoggo(),
            AnimatedCurtain(
              duration: _animationDuration,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              top: showMessage ? -MediaQuery.of(context).size.height / 2 : 0,
              showMessage: showMessage,
              startColor: Colors.purple,
              endColor: Color(0xFF002BFF),
            ),
            AnimatedCurtain(
              duration: _animationDuration,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              bottom: showMessage ? -MediaQuery.of(context).size.height / 2 : 0,
              showMessage: showMessage,
              startColor: Colors.green,
              endColor: Colors.yellow,
            ),
            AnimatedCurtain(
              duration: _animationDuration,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
              left: showMessage ? -MediaQuery.of(context).size.width / 2 : 0,
              showMessage: showMessage,
              startColor: Colors.blue,
              endColor: Colors.indigo,
            ),
            AnimatedCurtain(
              duration: _animationDuration,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
              right: showMessage ? -MediaQuery.of(context).size.width / 2 : 0,
              showMessage: showMessage,
              startColor: Colors.orange,
              endColor: Colors.red,
            ),
            AnimatedBuilder(
              animation: _bounceBoxAnimation,
              builder: builder,
            )
          ],
        ),
      ),
    );
  }

  void startAnimation() {
    setState(() => showMessage = !showMessage);
    _controller.forward();
    _spinningController.repeat();

    Future.delayed(_boxDuration).then(futureHandler);
  }

  void futureHandler(_) {
    if (mounted) {
      _controller.reverse();
      setState(() => showMessage = !showMessage);

      Future.delayed(_boxDuration).then((_) => _spinningController.stop());
    }
  }

  Widget builder(BuildContext context, _) {
    final boxAnimationValue = _bounceBoxAnimation.value;

    return Positioned(
      left: boxAnimationValue.toDouble(),
      top: _verticalAnimation.value,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: RotationTransition(
          turns: _spinningCurve,
          child: PieselImage(
            pieselSizeAnimation: _pieselSizeAnimation,
          ),
        ),
      ),
    );
  }
}
