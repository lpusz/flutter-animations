import 'package:flutter/material.dart';
import 'package:ninja_trips/models/trip.dart';

class DetailsImageHeader extends StatelessWidget {
  final Trip trip;

  const DetailsImageHeader({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Hero(
        tag: 'location-img-${trip.img}',
        child: Image.asset(
          'images/${trip.img}',
          height: 360,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
