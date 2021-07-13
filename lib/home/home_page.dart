import '../ui_components/menu_button.dart';
import 'package:ace_of_spades/courses/course_search_page.dart';
import 'package:ace_of_spades/feedback/feedback_page.dart';
import 'package:ace_of_spades/notices/notice_page.dart';
import 'package:ace_of_spades/person/person_page.dart';
import 'package:ace_of_spades/utils/under_construction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  static String id = '/homePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MenuButton(
              buttonIcon: FontAwesomeIcons.calendar,
              buttonText: 'Academic Calender',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UnderConstruction()));
              },
            ),
            MenuButton(
              buttonIcon: FontAwesomeIcons.calendarDay,
              buttonText: 'Events',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UnderConstruction()));
              },
            ),
            MenuButton(
              buttonIcon: FontAwesomeIcons.book,
              buttonText: 'Course Search',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CourseSearchPage()));
              },
            ),
            MenuButton(
                buttonIcon: FontAwesomeIcons.users,
                buttonText: 'Find People',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PersonPage()));
                }),
            MenuButton(
                buttonIcon: FontAwesomeIcons.bullhorn,
                buttonText: 'Notices',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoticePage()));
                }),
            MenuButton(
              buttonIcon: FontAwesomeIcons.cog,
              buttonText: 'Settings',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UnderConstruction()));
              },
            ),
            MenuButton(
              buttonIcon: FontAwesomeIcons.solidCommentAlt,
              buttonText: 'Feedback',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
