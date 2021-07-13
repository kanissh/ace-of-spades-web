import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/manage_courses/manage_course_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCourseSearch extends SearchDelegate {
  final Future<QuerySnapshot> addCourseList;
  final bool isRegistrationOpenAdd;
  final String semester;
  final String year;

  AddCourseSearch(
      {@required this.addCourseList,
      @required this.isRegistrationOpenAdd,
      @required this.semester,
      @required this.year});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: addCourseList,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No Data!',
              ),
            );
          }

          final results = snapshot.data.docs.where((p) {
            if (p['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
                p['code']
                    .toString()
                    .replaceAll(' ', '')
                    .toLowerCase()
                    .contains(query.replaceAll(' ', '').toLowerCase())) {
              return true;
            } else {
              return false;
            }
          });

          return ListView(
            //display list during typing the query
            children: results.map(
              (DocumentSnapshot documentSnapshot) {
                return ManageCourseTileAdd(
                  course: Course.convertCourseMapToObject(documentSnapshot.data()),
                  isRegistrationOpenAdd: isRegistrationOpenAdd,
                  semester: semester,
                  year: year,
                );
              },
            ).toList(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: addCourseList,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No Data!',
              ),
            );
          }

          final results = snapshot.data.docs.where((p) {
            if (p['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
                p['code']
                    .toString()
                    .replaceAll(' ', '')
                    .toLowerCase()
                    .contains(query.replaceAll(' ', '').toLowerCase())) {
              return true;
            } else {
              return false;
            }
          });

          return ListView(
            //display list during typing the query
            children: results.isEmpty
                ? [
                    ListTile(
                      title: Text('No matches found!'),
                    )
                  ]
                : results.map(
                    (DocumentSnapshot documentSnapshot) {
                      return ManageCourseTileAdd(
                        course: Course.convertCourseMapToObject(documentSnapshot.data()),
                        isRegistrationOpenAdd: isRegistrationOpenAdd,
                        semester: semester,
                        year: year,
                      );
                    },
                  ).toList(),
          );
        });
  }
}
