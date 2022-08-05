import 'package:flutter/material.dart';

import '../../models/trip.dart';

class TripTileTitle extends StatelessWidget {
  final Trip trip;

  const TripTileTitle({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${trip.nights} nights',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue[300],
          ),
        ),
        Text(
          trip.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
