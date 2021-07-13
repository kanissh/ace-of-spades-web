import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Divider blockDivider = Divider(color: borderColor);

const Color menuIconColor = Color(0xFF9D170E);

const Color redColor = Color(0xFF9D170E);

const Color borderColor = Color(0xFFC8C8C8);

const Color creditsLabelColor = Color(0xFF2E7D32);

const TextStyle bodyText18 = TextStyle(fontSize: 18, color: Colors.black);

const TextStyle bodyText28Monred = TextStyle(fontSize: 28, color: redColor, fontFamily: 'Montserrat');

const TextStyle bodyText18b = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

const TextStyle subtitle18i = TextStyle(fontSize: 18, fontStyle: FontStyle.italic);

const TextStyle subtitle14 = TextStyle(fontSize: 14);

const TextStyle creditsLabelText = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);

const TextStyle subtitle18ired = TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Color(0xFF9D170E));

const TextStyle subtitle16red = TextStyle(fontSize: 16, fontStyle: FontStyle.normal, color: Color(0xFF9D170E));

const TextStyle subtitle16 = TextStyle(
  fontSize: 16,
  fontStyle: FontStyle.normal,
);

const TextStyle subtitle16i = TextStyle(
  fontSize: 16,
  fontStyle: FontStyle.italic,
);

const TextStyle title22b = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
const TextStyle linkText18b = TextStyle(
  fontSize: 18,
  color: Color(0xFF0D47A1),
  decoration: TextDecoration.underline,
);

const Map<String, num> GRADEPOINTS = {
  'A+': 4,
  'A': 4,
  'A-': 3.7,
  'B+': 3.3,
  'B': 3,
  'B-': 2.7,
  'C+': 2.3,
  'C': 2,
  'C-': 1.7,
  'D+': 1.3,
  'D': 1,
  'E': 0
};

const TextStyle gpaDisplayStyle = TextStyle(
  fontSize: 53,
  color: redColor,
  fontWeight: FontWeight.w600,
);

const TextStyle buttonTextW = TextStyle(fontSize: 18, color: Colors.white);
