import 'package:ace_of_spades/constants.dart';
import 'package:flutter/material.dart';

class TimeLabel extends StatelessWidget {
  final String time;

  TimeLabel({this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: creditsLabelColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          time,
          style: creditsLabelText,
        ),
      ),
    );
  }
}
