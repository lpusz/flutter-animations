import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Trip.dart';
import 'package:ninja_trips/screens/details.dart';
import 'package:ninja_trips/screens/sand_box.dart';
import 'package:ninja_trips/screens/sand_box_2.dart';

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
      _addTrips();
    });
  }

  void _addTrips() async {
    List<dynamic> elements = [
      Trip(title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.jpg'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'city.jpg'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.jpg'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.jpg'),
      'SandBox',
      'AnimationSandbox',
    ];

    // -- Stream impl
    await for (final element in Stream.fromIterable(elements)) {
      await Future.delayed(Duration(milliseconds: 200));
      if (element is Trip) {
        _tripTiles.add(_buildTile(element));
      } else if (element is String) {
        if (element == 'AnimationSandbox') {
          _tripTiles.add(_buildSandboxButton(element, _openAnimationSandbox));
        } else if (element == 'SandBox') {
          _tripTiles.add(_buildSandboxButton(element, _openBasicSandbox));
        }
      }

      _listKey.currentState?.insertItem(_tripTiles.length - 1);
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

  Widget _buildTile(Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(trip: trip)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${trip.nights} nights',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text(trip.title, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'location-img-${trip.img}',
          child: Image.asset(
            'images/${trip.img}',
            height: 50.0,
          ),
        ),
      ),
      trailing: Text('\$${trip.price}'),
    );
  }

  Widget _buildSandboxButton(String text, void Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.orangeAccent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _tripTiles.length,
      itemBuilder: (BuildContext context, int index, Animation animation) {
        return SlideTransition(
          position: animation.drive(_offset),
          child: _tripTiles[index],
        );
      },
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
