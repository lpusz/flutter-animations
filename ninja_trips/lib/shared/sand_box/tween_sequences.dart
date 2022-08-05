import 'package:flutter/material.dart';

final bounceBoxSequence = TweenSequence(
  <TweenSequenceItem<int>>[
    TweenSequenceItem<int>(tween: IntTween(begin: 0, end: 150), weight: 15),
    TweenSequenceItem<int>(tween: IntTween(begin: 150, end: 0), weight: 15),
    TweenSequenceItem<int>(tween: IntTween(begin: 0, end: 75), weight: 15),
    TweenSequenceItem<int>(tween: IntTween(begin: 75, end: 0), weight: 15),
    TweenSequenceItem<int>(tween: IntTween(begin: 0, end: 300), weight: 20),
    TweenSequenceItem<int>(tween: IntTween(begin: 300, end: 0), weight: 20),
  ],
);

final pieselSizeSequence = TweenSequence<int>(<TweenSequenceItem<int>>[
  TweenSequenceItem(tween: IntTween(begin: 50, end: 100), weight: 15),
  TweenSequenceItem(tween: IntTween(begin: 100, end: 50), weight: 15),
  TweenSequenceItem(tween: IntTween(begin: 50, end: 75), weight: 15),
  TweenSequenceItem(tween: IntTween(begin: 75, end: 50), weight: 15),
  TweenSequenceItem(tween: IntTween(begin: 50, end: 150), weight: 20),
  TweenSequenceItem(tween: IntTween(begin: 150, end: 50), weight: 20),
]);