import 'package:flutter/material.dart';

import '../../models/trip.dart';

class TripTileImage extends StatelessWidget {
  final Trip trip;

  const TripTileImage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Hero(
        tag: 'location-img-${trip.img}',
        child: Image.asset(
          'images/${trip.img}',
          height: 50.0,
        ),
      ),
    );
  }
}
