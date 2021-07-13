import 'package:flutter/material.dart';

import '../constants.dart';

class SemesterLabel extends StatefulWidget {
  SemesterLabel({@required String semesterYear, @required semester})
      : _semester = semester,
        _semesterYear = semesterYear;

  final String _semester;
  final String _semesterYear;

  @override
  _SemesterLabelState createState() => _SemesterLabelState();
}

class _SemesterLabelState extends State<SemesterLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          children: [
            Text(
              widget._semesterYear,
              style: subtitle16red,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: redColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child:
                    widget._semester == null || widget._semester.isEmpty || !widget._semester.contains(RegExp(r'[1,2]'))
                        ? Container()
                        : Text(
                            widget._semester == '1' ? 'I' : 'II',
                            style: subtitle16red,
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
