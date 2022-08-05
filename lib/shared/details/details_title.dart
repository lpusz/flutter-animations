import 'package:flutter/material.dart';
import 'package:ninja_trips/models/trip.dart';
import 'package:ninja_trips/shared/details/heart.dart';

class DetailsTitle extends StatelessWidget {
  final Trip trip;

  const DetailsTitle({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        trip.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.grey[800],
        ),
      ),
      subtitle: Text(
        '${trip.nights} night stay for only \$${trip.price}',
        style: TextStyle(
          letterSpacing: 1,
        ),
      ),
      trailing: Heart(),
    );
  }
}
