import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/onboarding/info_onb_page.dart';
import 'package:ace_of_spades/onboarding/manage_onb_page.dart';
import 'package:ace_of_spades/onboarding/map_onb_page.dart';
import 'package:ace_of_spades/onboarding/welcome_page.dart';
import 'package:ace_of_spades/signin/signin.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController;
  int currentIndex = 0;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: onChangedFunction,
              controller: _pageController,
              children: [
                WelcomePage(),
                ManageOnBoardPage(),
                InfoOnBoardPage(),
                MapOnBoardPage(),
                SignIn(),
              ],
            ),
            Positioned(
              bottom: 25,
              left: (MediaQuery.of(context).size.width / 2) - 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Indicator(
                    positionIndex: 0,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 1,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 2,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 3,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 4,
                    currentIndex: currentIndex,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _pageController.jumpToPage(4);
                },
                child: Text(
                  'Skip',
                  style: subtitle16red,
                ),
              ),
            ), /* Positioned(
              bottom: 30,
              left: 130,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(onTap: () => previousFunction(), child: Text("Previous")),
                      SizedBox(
                        width: 50,
                      ),
                      InkWell(onTap: () => nextFunction(), child: Text("Next"))
                    ],
                  ),
                ),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          border: Border.all(color: redColor),
          color: positionIndex == currentIndex ? redColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
