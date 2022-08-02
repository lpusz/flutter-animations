import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Trip.dart';
import 'package:ninja_trips/screens/details.dart';

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
    List<Trip> _trips = [
      Trip(title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.jpg'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'city.jpg'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.jpg'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.jpg'),
    ];

    // -- Stream impl
    await for (final trip in Stream.fromIterable(_trips)) {
      await Future.delayed(Duration(milliseconds: 200));
      _tripTiles.add(_buildTile(trip));
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
}
