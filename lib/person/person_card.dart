import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/person/person.dart';
import 'package:ace_of_spades/person/person_profile.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String position;
  final String department;
  final Map<String, dynamic> personDocument;

  PersonCard(
      {@required this.name,
      @required this.position,
      @required this.department,
      this.personDocument});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Person _person = Person(
            name: personDocument['name'],
            position: personDocument['position'],
            department: personDocument['department']);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonProfile(
                      person: personDocument,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: borderColor, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: bodyText18,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                position,
                style: subtitle18ired,
              ),
              Text(
                department,
                style: subtitle18i,
              )
            ],
          ),
        ),
      ),
    );
  }
}
