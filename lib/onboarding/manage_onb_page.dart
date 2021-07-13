import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/constants/illustration_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManageOnBoardPage extends StatelessWidget {
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
                  illustrationManage,
                  height: MediaQuery.of(context).size.height * 0.3,
                  semanticsLabel: 'Manage illustration',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Manage',
                  style: bodyText28Monred,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Manage your course enrollments and grades efficiently',
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
