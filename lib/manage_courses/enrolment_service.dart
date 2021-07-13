import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/course_status.dart';
import 'package:ace_of_spades/constants/course_remarks.dart';
import 'package:ace_of_spades/constants/grades.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EnrolmentService {
  static addCourse(Course course, String remarks, String semester, String year) async {
    var studentDocument = FirebaseFirestore.instance
        .collection('${DbConfigPath.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
        .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());

    //TODO: Test above

    //var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');
    var courseList =
        await studentDocument.get().then((DocumentSnapshot documentSnapshot) => documentSnapshot['courses']);

    StudentCourse studentCourse = StudentCourse(
        code: course.code,
        name: course.name,
        credits: course.credits[course.credits.firstKey()],
        grade: Grades.O,
        semester: semester, //TODO: semester and year needed variable from db
        year: year,
        courseDocRef: FirebaseFirestore.instance
            .collection(DbConfigPath.COURSE)
            .doc(course.code.replaceAll(' ', '')), //FIXME: document names differ
        status: CourseStatus.ENROLLED,
        remarks: remarks);

    if (remarks == CourseRemarks.PROPER) {
      if (courseList.any((element) => element['course_code'].toString().toUpperCase() == course.code.toUpperCase())) {
        throw Exception('You have enrolled in this course previously as a $remarks candidate.');
      } else {
        studentDocument.update({
          'courses': FieldValue.arrayUnion([studentCourse.getMap()])
        });

        studentDocument.update({'current_credits': FieldValue.increment(studentCourse.credits)});

        throw 'Successfully enrolled to ${course.code}';
      }
    } else if (remarks == CourseRemarks.MEDICAL_PROPER || remarks == CourseRemarks.SPECIAL) {
      if (courseList.any((element) {
        return element['course_code'].toString().toUpperCase() == course.code.toUpperCase() &&
            (element['grade'] == Grades.O || element['grade'] == Grades.I);
      })) {
        studentDocument.update({
          'courses': FieldValue.arrayUnion([studentCourse.getMap()])
        });

        throw 'Successfully enrolled to ${course.code} as a $remarks candidate';
      } else {
        throw Exception('Not enrolled in this course previously. Cannot enrol in this course as a $remarks candidate.');
      }
    } else {
      if (courseList.any((element) {
        return element['course_code'].toString().toUpperCase() == course.code.toUpperCase() &&
            (element['grade'] == Grades.C_MINUS ||
                element['grade'] == Grades.D ||
                element['grade'] == Grades.D_PLUS ||
                element['grade'] == Grades.E);
      })) {
        studentDocument.update({
          'courses': FieldValue.arrayUnion([studentCourse.getMap()])
        });

        throw 'Successfully enrolled to ${course.code} as a $remarks candidate';
      } else {
        throw Exception(
            'Criteria fulfilled to pass the course or not enrolled in this course previously.\n\nCannot enrol as a repeat student.');
      }
    }
  }

  static removeCourse(StudentCourse studentCourse) {
    var studentDocument = FirebaseFirestore.instance
        .collection('${DbConfigPath.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
        .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());

    //TODO: Test above

    //var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');
    studentDocument.update({
      'courses': FieldValue.arrayRemove([studentCourse.getMap()])
    });

    studentDocument.update({'current_credits': FieldValue.increment(-studentCourse.credits)});
  }
}
