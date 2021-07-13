import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/courses/course_details_page.dart';
import 'package:flutter/material.dart';
import 'course.dart';
import '../ui_components/credit_label.dart';

class CourseTile extends StatelessWidget {
  final Course course;

  CourseTile(this.course);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(course),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: borderColor, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    course.code,
                    style: bodyText18b,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CreditLabel(
                    credits: course.credits.values.first.toString(),
                    //credits: course.credits[DateTime.now().year.toString()].toString()==null?course.credits.values.first.toString():course.credits[DateTime.now().year.toString()].toString()
                  ),
                ],
              ),
              Text(
                course.name,
                style: subtitle18i,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                course.desc,
                style: subtitle14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
