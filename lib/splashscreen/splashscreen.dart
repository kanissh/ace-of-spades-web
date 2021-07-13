import 'package:ace_of_spades/onboarding/on_boarding.dart';
import 'package:ace_of_spades/the_stage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              child: Text('Checking...'), // FIXME: error show directionality
              color: Colors.white,
            ),
          );
        } else {
          if (snapshot.hasData) {
            return TheStage(snapshot.data);
          } else {
            return OnBoardingScreen();
          }
        }
      },
    );
  }
}
