import 'package:flutter/material.dart';
import 'package:ninja_trips/shared/rotatable_doggo.dart';

class AnimationSandBox extends StatefulWidget {
  const AnimationSandBox({Key? key}) : super(key: key);

  @override
  State<AnimationSandBox> createState() => _AnimationSandBoxState();
}

class _AnimationSandBoxState extends State<AnimationSandBox> with TickerProviderStateMixin {
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
    _controller = AnimationController(
      duration: _boxDuration,
      vsync: this,
    );
    _spinningController = AnimationController(
      duration: _boxDuration,
      vsync: this,
    );

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    _spinningCurve = CurvedAnimation(
      parent: _spinningController,
      curve: Curves.linear,
    );

    _bounceBoxAnimation = TweenSequence(
      <TweenSequenceItem<int>>[
        TweenSequenceItem<int>(
          tween: IntTween(begin: 0, end: 150),
          weight: 15,
        ),
        TweenSequenceItem<int>(
          tween: IntTween(begin: 150, end: 0),
          weight: 15,
        ),
        TweenSequenceItem<int>(
          tween: IntTween(begin: 0, end: 75),
          weight: 15,
        ),
        TweenSequenceItem<int>(
          tween: IntTween(begin: 75, end: 0),
          weight: 15,
        ),
        TweenSequenceItem<int>(
          tween: IntTween(begin: 0, end: 300),
          weight: 20,
        ),
        TweenSequenceItem<int>(
          tween: IntTween(begin: 300, end: 0),
          weight: 20,
        ),
      ],
    ).animate(_curve);

    _verticalAnimation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(_curve);

    _pieselSizeAnimation = TweenSequence<int>(<TweenSequenceItem<int>>[
      TweenSequenceItem(tween: IntTween(begin: 50, end: 100), weight: 15),
      TweenSequenceItem(tween: IntTween(begin: 100, end: 50), weight: 15),
      TweenSequenceItem(tween: IntTween(begin: 50, end: 75), weight: 15),
      TweenSequenceItem(tween: IntTween(begin: 75, end: 50), weight: 15),
      TweenSequenceItem(tween: IntTween(begin: 50, end: 150), weight: 20),
      TweenSequenceItem(tween: IntTween(begin: 150, end: 50), weight: 20),
    ]).animate(_curve);
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
        title: Text('Sand box'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => showMessage = !showMessage);
              _controller.forward();
              _spinningController.repeat();

              Future.delayed(_boxDuration).then((value) {
                if (mounted) {
                  _controller.reverse();
                  setState(() => showMessage = !showMessage);
                  Future.delayed(_boxDuration).then((value) => _spinningController.stop());
                }
              });
            },
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
            AnimatedPositioned(
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: !showMessage ? Colors.purple : Color(0xFF002BFF),
                duration: _animationDuration,
              ),
              duration: _animationDuration,
              top: showMessage ? -MediaQuery.of(context).size.height / 2 : 0,
            ),
            AnimatedPositioned(
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: !showMessage ? Colors.green : Colors.yellow,
                duration: _animationDuration,
              ),
              duration: _animationDuration,
              bottom: showMessage ? -MediaQuery.of(context).size.height / 2 : 0,
            ),
            AnimatedPositioned(
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                color: !showMessage ? Colors.blue : Colors.indigo,
                duration: _animationDuration,
              ),
              duration: _animationDuration,
              left: showMessage ? -MediaQuery.of(context).size.width / 2 : 0,
            ),
            AnimatedPositioned(
              child: AnimatedContainer(
                duration: _animationDuration,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                color: showMessage ? Colors.orange : Colors.red,
              ),
              duration: _animationDuration,
              right: showMessage ? -MediaQuery.of(context).size.width / 2 : 0,
            ),
            AnimatedBuilder(
              animation: _bounceBoxAnimation,
              builder: (context, _) {
                return Positioned(
                  left: _bounceBoxAnimation.value.toDouble(),
                  top: _verticalAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: RotationTransition(
                      turns: _spinningCurve,
                      child: Image.asset(
                        'images/piesel.jpg',
                        height: _pieselSizeAnimation.value.toDouble(),
                        width: _pieselSizeAnimation.value.toDouble(),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
