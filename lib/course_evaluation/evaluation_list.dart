import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/course_evaluation/fill_evaluation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EvaluationList extends StatefulWidget {
  final List pendingCourseList;
  EvaluationList({this.pendingCourseList});

  @override
  _EvaluationListState createState() => _EvaluationListState();
}

class _EvaluationListState extends State<EvaluationList> {
  CollectionReference evalRef = FirebaseFirestore.instance.collection(DbConfigPath.COURSE_EVALUATION);

  List<String> getCourseCode(List list) {
    List<String> results = List();

    for (var item in list) {
      results.add(item['course_code'].toString().toUpperCase());
    }
    print(results);

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: evalRef.where('course_code', whereIn: getCourseCode(widget.pendingCourseList)).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(redColor),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView.separated(
              separatorBuilder: (context, index) => blockDivider,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data.docs[index]['course_code'].toString(),
                    style: bodyText18,
                  ),
                  subtitle: Text(snapshot.data.docs[index]['name'].toString(), style: subtitle18i),
                  isThreeLine: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FillEvaluation(evalDocument: snapshot.data.docs[index].data()),
                      ),
                    );
                  },
                );
              },
            );
          }

          return Center(
            child: Text('Unexpected error occurred'),
          );
        });
  }
}
