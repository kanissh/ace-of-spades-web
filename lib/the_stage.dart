import 'package:ace_of_spades/map/map_page.dart';
import 'package:ace_of_spades/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home/home_page.dart';

class TheStage extends StatefulWidget {
  final User _user;
  TheStage(@required this._user);

  @override
  _TheStageState createState() => _TheStageState();
}

class _TheStageState extends State<TheStage> {
  int _selectedIndex = 0;

  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _bottomNavPages = [
      HomePage(),
      ProfilePage(widget._user),
      MapPage(),
    ];

    return Scaffold(
      body: _bottomNavPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.userAlt), label: 'Profile'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.mapMarkedAlt), label: 'Map')
        ],
        currentIndex: _selectedIndex,
        onTap: _onBottomItemTapped,
      ),
    );
  }
}
