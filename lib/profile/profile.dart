import '../ui_components/menu_button.dart';
import 'package:ace_of_spades/class_schedule/class_schedule_page.dart';
import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/course_evaluation/course_evaluation_page.dart';
import 'package:ace_of_spades/grades/grades_page.dart';
import 'package:ace_of_spades/manage_courses/manage_courses_page.dart';
import 'package:ace_of_spades/schedules/exam_schedule_page.dart';
import 'package:ace_of_spades/signin/signin_service.dart';
import 'package:ace_of_spades/splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  static String id = '/profilePage';
  final Color backgroundColor = Color(0xFFDDDDDD);

  final User _user;
  ProfilePage(this._user);

  //TODO: add error handling for user
  //TODO: add null checking for user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                //Avatar circle profile image
                backgroundImage: NetworkImage(_user.photoURL),
                backgroundColor: Colors.white,
                radius: 64,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _user.displayName,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF9D170E),
                ),
              ),
              Text(_user.email, style: bodyText18),
              Text(
                _user.email.split('@')[0].toUpperCase(), //registration number
                style: bodyText18,
              ),
              // Text(
              //   'Bsc in physical science', //TODO: figureout a way to rectify this dynamically
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontStyle: FontStyle.italic,
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              MenuButton(
                buttonIcon: FontAwesomeIcons.graduationCap,
                buttonText: 'Manage Courses',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageCoursesPage(),
                    ),
                  );
                },
              ),
              MenuButton(
                  buttonIcon: FontAwesomeIcons.font,
                  buttonText: 'Grades',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GradesPage(),
                      ),
                    );
                    //Navigator.pushNamed(context, GradesPage.id);
                  }),
              MenuButton(
                buttonIcon: FontAwesomeIcons.clock,
                buttonText: 'Class Schedule',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassSchedulePage(),
                    ),
                  );
                },
              ),
              MenuButton(
                buttonIcon: FontAwesomeIcons.clipboard,
                buttonText: 'Exam Schedule',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamSchedulePage(),
                    ),
                  );
                },
              ),
              MenuButton(
                buttonIcon: FontAwesomeIcons.star,
                buttonText: 'Course Evaluation',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseEvaluationPage(),
                    ),
                  );
                },
              ),
              MenuButton(
                buttonIcon: FontAwesomeIcons.signOutAlt,
                buttonText: 'Sign out',
                onTap: () async {
                  await signOutGoogle();

                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,*/
