import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      builder: (BuildContext context, double tweenValue, Widget? child) {
        return Opacity(
          opacity: tweenValue,
          child: Padding(
            padding: EdgeInsets.only(top: tweenValue * 20),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
