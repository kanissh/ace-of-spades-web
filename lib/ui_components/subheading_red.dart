import 'package:flutter/material.dart';

import '../constants.dart';

class SubHeadingRed extends StatelessWidget {
  final String title;

  SubHeadingRed({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style:
          TextStyle(fontSize: 14, color: redColor, fontWeight: FontWeight.bold),
    );
  }
}
