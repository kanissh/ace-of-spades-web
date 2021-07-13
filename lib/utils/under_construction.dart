import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/constants/illustration_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnderConstruction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                illustrationUnderConstruction,
                height: MediaQuery.of(context).size.height * 0.3,
                semanticsLabel: 'Under construction illustration',
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Bear with us!!!\n This page is currently under construction',
                style: bodyText18,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
