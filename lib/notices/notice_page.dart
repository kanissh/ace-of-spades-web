import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/notices/notice_card.dart';
import 'package:ace_of_spades/notices/notice_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  var notices = FirebaseFirestore.instance.collection(DbConfigPath.NOTICE).orderBy('published_date', descending: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notices'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: notices.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching data'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading'),
                );
              }

              if (snapshot.connectionState == ConnectionState.active) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                    return NoticeCard(
                      noticeObject: NoticeObject.convertDocToObject(documentSnapshot),
                    );
                  },
                );
              }

              return Center(
                child: Text('Error fetching data'),
              );
            },
          ),
        ),
      ),
    );
  }
}
