import 'package:flutter/material.dart';

class Person {
  String name;
  String position;
  String academicCred;
  List<String> email;
  List<String> mobile;
  List<String> phone;
  String department; //FIXME: consider an enum value

  Person(
      {@required this.name,
      @required this.position,
      this.academicCred,
      // @required this.email,
      this.email,
      this.phone,
      this.mobile,
      @required this.department});
}
