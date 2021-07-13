import 'package:ace_of_spades/constants.dart';

class CalculateGpa {
  static num calculateGpa({List courseList}) {
    num sum = 0;
    num totalCredits = 0;

    for (var course in courseList) {
      switch (course['grade'].toString().toUpperCase()) {
        case ('A+'):
          sum += GRADEPOINTS['A+'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('A'):
          sum += GRADEPOINTS['A'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('A-'):
          sum += GRADEPOINTS['A-'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('B+'):
          sum += GRADEPOINTS['B+'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('B'):
          sum += GRADEPOINTS['B'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('B-'):
          sum += GRADEPOINTS['B-'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('C+'):
          sum += GRADEPOINTS['C+'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('C'):
          sum += GRADEPOINTS['C'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('C-'):
          sum += GRADEPOINTS['C-'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('D+'):
          sum += GRADEPOINTS['D+'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('D'):
          sum += GRADEPOINTS['D'] * course['credits'];
          totalCredits += course['credits'];
          break;

        case ('E'):
          sum += GRADEPOINTS['E'] * course['credits'];
          totalCredits += course['credits'];
          break;

        default:
      }
    }

    return (sum / totalCredits);
  }
}
