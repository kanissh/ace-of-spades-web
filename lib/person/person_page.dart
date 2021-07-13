import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/person/people_search.dart';
import 'package:ace_of_spades/person/person_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  Future<QuerySnapshot> people = FirebaseFirestore.instance.collection(DbConfigPath.PEOPLE).get();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: redColor,
          onPressed: () {
            showSearch(context: context, delegate: PeopleSearch(people));
          },
          child: Icon(Icons.search),
        ),
        appBar: AppBar(
          title: Text('Find People'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: people,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error detected'),
              );
              //TODO: Fix above error handling
            } else if (snapshot.hasData) {
              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                  return PersonCard(
                    name: documentSnapshot['name'],
                    position: documentSnapshot['position'],
                    department: documentSnapshot['department'],
                    personDocument: documentSnapshot.data(),
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(redColor),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
