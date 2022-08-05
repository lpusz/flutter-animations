import 'package:flutter/material.dart';
import 'package:ninja_trips/models/trip.dart';
import 'package:ninja_trips/screens/details.dart';
import 'package:ninja_trips/shared/list/trip_tile_image.dart';
import 'package:ninja_trips/shared/list/trip_tile_title.dart';

class TripTile extends StatelessWidget {
  final Trip trip;

  const TripTile({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _onTap(context),
      contentPadding: EdgeInsets.all(25),
      title: TripTileTitle(trip: trip),
      leading: TripTileImage(trip: trip),
      trailing: Text('\$${trip.price}'),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Details(trip: trip),
      ),
    );
  }
}



