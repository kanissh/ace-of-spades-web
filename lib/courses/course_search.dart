import 'course_Tile.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'course_details_page.dart';

class CourseSearch extends SearchDelegate {
  final Future<QuerySnapshot> courseList;
  final List<String> subjectFilters;
  final List<String> levelFilters;
  final List<String> creditFilters;

  CourseSearch({this.courseList, this.subjectFilters, this.levelFilters, this.creditFilters});

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
    return FutureBuilder<QuerySnapshot>(
      future: courseList,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data!'),
          );
        }

        List<QueryDocumentSnapshot> results = snapshot.data.docs;

        if (subjectFilters.isNotEmpty) {
          results = results.where((c) {
            print(c['code'].toString().split(' ')[1][0]);
            return subjectFilters.contains(c['subject'].toString());
          }).toList();
        }

//FIXME: fix splaytree map retrieval
        if (creditFilters.isNotEmpty) {
          results = results.where((c) {
            return creditFilters.contains(c['credits'][DateTime.now().year.toString()].toString());
          }).toList();
        }

        if (levelFilters.isNotEmpty) {
          results = results.where((c) {
            return levelFilters.contains(c['code'].toString().split(' ')[1][0] + '00');
          }).toList();
        }

        results = results.where((c) {
          return c['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
              c['code'].toString().toLowerCase().contains(query.toLowerCase());
        }).toList();

        return ListView(
          children: results.map(
            (DocumentSnapshot documentSnapshot) {
              return CourseTile(Course.convertCourseDocToObject(documentSnapshot));
            },
          ).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: courseList,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data!'),
          );
        }

        List<QueryDocumentSnapshot> results = snapshot.data.docs;

        if (subjectFilters.isNotEmpty) {
          results = results.where((c) {
            print(c['code'].toString().split(' ')[1][0]);
            return subjectFilters.contains(c['subject'].toString());
          }).toList();
        }

//FIXME: fix splaytree map retrieval
        if (creditFilters.isNotEmpty) {
          results = results.where((c) {
            return creditFilters.contains(c['credits'][DateTime.now().year.toString()].toString());
          }).toList();
        }

        if (levelFilters.isNotEmpty) {
          results = results.where((c) {
            return levelFilters.contains(c['code'].toString().split(' ')[1][0] + '00'); //to make 3 => 300
          }).toList();
        }

        results = results.where((c) {
          return c['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
              c['code'].toString().toLowerCase().contains(query.toLowerCase());
        }).toList();

        return ListView(
          children: results.map(
            (DocumentSnapshot documentSnapshot) {
              return ListTile(
                title: Text(documentSnapshot['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailsPage(Course.convertCourseDocToObject(documentSnapshot)),
                    ),
                  );
                },
              );
            },
          ).toList(),
        );
      },
    );
  }
}
