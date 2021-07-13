import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeObject {
  String desc;
  String title;
  DateTime publishedDate;
  List<dynamic> fileList;

  NoticeObject({this.title, this.desc, this.publishedDate, this.fileList});

  static NoticeObject convertDocToObject(DocumentSnapshot documentSnapshot) {
    return NoticeObject(
        title: documentSnapshot['title'],
        desc: documentSnapshot['desc'],
        publishedDate: documentSnapshot['published_date'].toDate(),
        fileList: documentSnapshot['files']);
  }
}
