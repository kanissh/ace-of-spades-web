import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCourse {
  final String code;
  final String name;
  final int credits;
  final String grade;
  final String semester;
  final String year;
  final DocumentReference courseDocRef;
  final String status;
  final String remarks;

  StudentCourse(
      {this.code,
      this.name,
      this.credits,
      this.grade,
      this.semester,
      this.year,
      this.courseDocRef,
      this.status,
      this.remarks});

  Map<String, dynamic> getMap() {
    return {
      'course_code': this.code,
      'course_doc': this.courseDocRef,
      'credits': this.credits,
      'grade': this.grade,
      'sem': this.semester,
      'name': this.name,
      'status': this.status,
      'year': this.year,
      'remarks': this.remarks
    };
  }

  static StudentCourse convertToObject(Map<String, dynamic> courseMap) {
    return StudentCourse(
        code: courseMap['course_code'],
        name: courseMap['name'],
        credits: courseMap['credits'],
        grade: courseMap['grade'],
        semester: courseMap['sem'],
        year: courseMap['year'],
        courseDocRef: courseMap['course_doc'],
        status: courseMap['status'],
        remarks: courseMap['remarks']);
  }
}
