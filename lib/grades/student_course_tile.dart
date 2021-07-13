import 'package:ace_of_spades/constants/grades.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/ui_components/credit_label.dart';
import 'package:ace_of_spades/ui_components/semester_label.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class StudentCourseTile extends StatelessWidget {
  const StudentCourseTile({
    Key key,
    @required StudentCourse studentCourse,
  })  : _studentCourse = studentCourse,
        super(key: key);

  final StudentCourse _studentCourse;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _studentCourse.code,
                        style: bodyText18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CreditLabel(
                        credits: _studentCourse.credits.toString(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SemesterLabel(
                    semester: _studentCourse.semester,
                    semesterYear: _studentCourse.year,
                  ),
                  /* Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      _studentCourse.year.toString() + ' ' + _studentCourse.semester.toString(),
                      style: subtitle16red,
                    ),
                  ), */
                  Text(
                    _studentCourse.name,
                    style: subtitle18i,
                  ),
                ],
              ),
            ),
            _studentCourse.grade == null || _studentCourse.grade == Grades.O || _studentCourse.grade.trim() == ''
                ? Container()
                : Expanded(
                    child: Text(
                      _studentCourse.grade,
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
          ],
        ),
      ),
    );
  }
}
