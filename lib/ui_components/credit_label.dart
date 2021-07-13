import 'package:ace_of_spades/constants.dart';
import 'package:flutter/material.dart';

class CreditLabel extends StatelessWidget {
  final String credits;

  CreditLabel({this.credits});

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
          credits + ' Credits',
          style: creditsLabelText,
        ),
      ),
    );
  }
}

/*course.credits[DateTime.now().year.toString()].toString()*/
