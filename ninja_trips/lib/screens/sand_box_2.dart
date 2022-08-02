import 'package:flutter/material.dart';
import 'package:ninja_trips/shared/rotatable_doggo.dart';

class SandBox2 extends StatefulWidget {
  const SandBox2({Key? key}) : super(key: key);

  @override
  State<SandBox2> createState() => _SandBox2State();
}

class _SandBox2State extends State<SandBox2> with SingleTickerProviderStateMixin {
  bool showMessage = false;

  final Duration _animationDuration = Duration(seconds: 3);
  final Duration _boxDuration = Duration(seconds: 3);

  late AnimationController _controller;
  late Animation<double> _curve;
  late Animation<int> _bounceBoxAnimation;
  late Animation<double> _verticalAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _boxDuration,
      vsync: this,
    );
    _curve = CurvedAnimation(
      parent: _controller,
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

    _controller.addStatusListener((status) {
      print(status);
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sand box'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => showMessage = !showMessage);
              _controller.forward();
              Future.delayed(_boxDuration).then((value) {
                _controller.reverse();
                setState(() => showMessage = !showMessage);
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.purple,
              ),
              duration: _animationDuration,
              top: showMessage ? -MediaQuery.of(context).size.height / 2 : 0,
            ),
            AnimatedPositioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.green,
              ),
              duration: _animationDuration,
              bottom: showMessage ? -MediaQuery.of(context).size.height / 2 : 0,
            ),
            AnimatedPositioned(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue,
              ),
              duration: _animationDuration,
              left: showMessage ? -MediaQuery.of(context).size.width / 2 : 0,
            ),
            AnimatedPositioned(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                color: Colors.orange,
              ),
              duration: _animationDuration,
              right: showMessage ? -MediaQuery.of(context).size.width / 2 : 0,
            ),
            AnimatedBuilder(
              animation: _bounceBoxAnimation,
              builder: (context, _) {
                // print(_verticalAnimation.value);
                print(MediaQuery.of(context).size.height);
                return Positioned(
                  left: _bounceBoxAnimation.value.toDouble(),
                  top: _verticalAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Image.asset(
                      'images/piesel.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
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
