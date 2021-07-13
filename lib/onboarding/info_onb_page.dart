import 'package:ace_of_spades/constants/illustration_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class InfoOnBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  illustrationInfo,
                  height: MediaQuery.of(context).size.height * 0.3,
                  semanticsLabel: 'Info illustration',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Be Informed',
                  style: bodyText28Monred,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Access course information, staff information, class schedules and notices',
                  style: bodyText18,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
