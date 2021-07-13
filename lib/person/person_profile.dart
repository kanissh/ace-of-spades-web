import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class PersonProfile extends StatelessWidget {
  const PersonProfile({
    Key key,
    @required this.person,
  }) : super(key: key);

  final Map<String, dynamic> person;

  //null checking for the person key value pair
  String checkNull(value) {
    if (value == null || value == '') {
      return 'Not Available';
    } else {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(person['imageUrl']),
                radius: 64,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Text(
                person['name'],
                style: bodyText18,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Text(
                checkNull(person['academicCred']),
                style: subtitle18i,
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 0,
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.userTie,
              content: checkNull(person['position']),
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.building,
              content: checkNull(person['department']),
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.solidEnvelope,
              content: checkNull(person['email'].toString().replaceAll(',', '\n').replaceAll(RegExp(r'[\[\] ]'), '')),
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.phoneAlt,
              content: checkNull(person['phone'].toString().replaceAll(',', '\n').replaceAll(RegExp(r'[\[\]]'), '')),
            ),
            PersonDetailsTile(
              icon: FontAwesomeIcons.mobileAlt,
              content: checkNull(person['mobile'].toString().replaceAll(',', '\n').replaceAll(RegExp(r'[\[\]]'), '')),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonDetailsTile extends StatelessWidget {
  final IconData icon;
  final String content;

  PersonDetailsTile({@required this.icon, @required this.content});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(this.icon),
      title: Text(
        this.content,
        style: bodyText18,
      ),
    );
  }
}
