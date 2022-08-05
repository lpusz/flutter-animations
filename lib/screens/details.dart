import 'package:flutter/material.dart';
import 'package:ninja_trips/models/trip.dart';
import 'package:ninja_trips/shared/details/details_description.dart';
import 'package:ninja_trips/shared/details/details_image_header.dart';
import 'package:ninja_trips/shared/details/details_title.dart';

class Details extends StatelessWidget {
  final Trip trip;

  Details({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DetailsImageHeader(trip: trip),
            SizedBox(height: 30),
            DetailsTitle(trip: trip),
            DetailsDescription(),
          ],
        ),
      ),
    );
  }
}
