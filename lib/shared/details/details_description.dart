import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class DetailsDescription extends StatelessWidget {
  const DetailsDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Text(
        lorem(paragraphs: 1, words: 32),
        style: TextStyle(
          color: Colors.grey[600],
          height: 1.4,
        ),
      ),
    );
  }
}