import 'package:flutter/material.dart';
import 'package:ninja_trips/models/trip.dart';
import 'package:ninja_trips/screens/animation_sand_box.dart';
import 'package:ninja_trips/screens/basic_sand_box.dart';
import 'package:ninja_trips/shared/list/element_list_fake.dart';
import 'package:ninja_trips/shared/sand_box/sand_box_button.dart';
import 'package:ninja_trips/shared/list/trip_tile.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<Widget> _tripTiles = [];
  Tween<Offset> _offset = Tween(
    begin: Offset(1, 0),
    end: Offset(0, 0),
  );

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addElements();
    });
  }

  void _addElements() async {
    // -- Stream impl
    final Stream<dynamic> stream = Stream.fromIterable(fakeList);
    await for (final element in stream) {
      await _insertElement(element);
    }

    // -- Basic Futures impl
    // Future<void> future = Future<void>(() {});
    // _trips.forEach((Trip trip) {
    //   future = future.then((_) {
    //     return Future.delayed(Duration(milliseconds: 200), () {
    //       _tripTiles.add(_buildTile(trip));
    //       _listKey.currentState?.insertItem(_tripTiles.length - 1);
    //     });
    //   });
    // });
  }

  Future<void> _insertElement(element) async {
    await Future.delayed(Duration(milliseconds: 200));

    if (element is Trip) {
      final tripTile = TripTile(trip: element);
      _tripTiles.add(tripTile);
    } else if (element is String) {
      buildCustomElement(element);
    }

    _listKey.currentState?.insertItem(_tripTiles.length - 1);
  }

  void buildCustomElement(String element) {
    if (element == 'AnimationSandbox') {
      final button = SandBoxButton(
        text: element,
        onTap: _openAnimationSandbox,
      );

      _tripTiles.add(button);
    } else if (element == 'SandBox') {
      final button = SandBoxButton(
        text: element,
        onTap: _openBasicSandbox,
      );

      _tripTiles.add(button);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _tripTiles.length,
      itemBuilder: builder,
    );
  }

  Widget builder(BuildContext context, int index, Animation animation) {
    return SlideTransition(
      position: animation.drive(_offset),
      child: _tripTiles[index],
    );
  }

  void _openBasicSandbox() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BasicSandBox()),
    );
  }

  void _openAnimationSandbox() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimationSandBox()),
    );
  }
}
