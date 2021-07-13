import 'package:ace_of_spades/person/person_card.dart';
import 'package:ace_of_spades/person/person_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeopleSearch extends SearchDelegate {
  final Future<QuerySnapshot> peopleList;

  PeopleSearch(this.peopleList);

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
      future: peopleList,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'No Data!',
            ),
          );
        }
        //TODO: handle this

        final results =
            snapshot.data.docs.where((p) => p['name'].toString().toLowerCase().contains(query.toLowerCase()));

        return ListView(
          //display list during typing the query
          children: results.map(
            (DocumentSnapshot documentSnapshot) {
              return PersonCard(
                name: documentSnapshot['name'],
                position: documentSnapshot['position'],
                department: documentSnapshot['department'],
                personDocument: documentSnapshot.data(),
              );
            },
          ).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: peopleList,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'No Data!',
            ),
          );
        }
        //TODO: handle this

        final results =
            snapshot.data.docs.where((p) => p['name'].toString().toLowerCase().contains(query.toLowerCase()));

        return ListView(
          //display list during typing the query
          children: results.map(
            (DocumentSnapshot documentSnapshot) {
              return ListTile(
                //FIXME: fix display text style
                title: Text(documentSnapshot['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonProfile(person: documentSnapshot.data()),
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

//TODO: add recent list
//TODO: add page title to scaffold in person profile
