import 'package:ace_of_spades/constants.dart';
import '../ui_components/credit_label.dart';
import 'package:ace_of_spades/ui_components/subheading_red.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'course.dart';

class CourseDetailsPage extends StatelessWidget {
  final Course course;

  CourseDetailsPage(this.course);

  String listToNumberedList(List list) {
    int i = 1;
    String result;

    if (list.isEmpty) {
      return 'Not Available';
    } else {
      for (String s in list) {
        result = '$i. $s\n';
        i++;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(course.code),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.code,
                  style: bodyText18b,
                ),
                blockDivider,
                Text(
                  course.name,
                  style: bodyText18,
                ),
                blockDivider,
                CreditLabel(credits: course.credits.values.first.toString()
                    //credits: course.credits[DateTime.now().year.toString()].toString()==null?course.credits.values.first.toString():course.credits[DateTime.now().year.toString()].toString()
                    ),
                blockDivider,
                Text(
                  'Prerequisites - ' +
                      (course.prereq.isNotEmpty ? course.prereq.toString().replaceAll(RegExp(r'[\[\]]'), "") : 'None'),
                  style: subtitle18i,
                ),
                blockDivider,
                SubHeadingRed(title: 'description'),
                blockDivider,
                Text(
                  course.desc.isNotEmpty ? course.desc : 'Not Available',
                  style: bodyText18,
                ),
                blockDivider,
                SubHeadingRed(title: 'instructors'),
                blockDivider,
                Text(
                  //TODO: instructor name not added to  course in database
                  // listToNumberedList(course.instructors),
                  'Not Available',
                  style: bodyText18,
                ),
                blockDivider,
                SubHeadingRed(
                  title: 'references',
                ),
                blockDivider,
                Text(
                  listToNumberedList(course.refBooks),
                  // course.refBooks.toString(),
                  style: bodyText18,
                ),
                blockDivider,
                SubHeadingRed(
                  title: 'Syllabus',
                ),

                //TODO: syllabus not added to course in the database
                blockDivider,
                Text(
                  //course.syllabus,
                  'Not Available',
                  style: bodyText18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
