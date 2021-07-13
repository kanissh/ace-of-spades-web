import 'package:ace_of_spades/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
        primaryColor: Color(0xFF9D170E),
        scaffoldBackgroundColor: Colors.white,
        // TODO: define TextStyleTheme for body, heading and others
        fontFamily: 'OpenSans',
      ),
      home: SafeArea(
        child: SplashScreen(),
      ),
      routes: {
        //GradesPage.id: (context) => GradesPage(),
      },
    );
  }
}

/*
TextTheme(
headline1: GoogleFonts.openSans(
fontSize: 95,
fontWeight: FontWeight.w300,
letterSpacing: -1.5
),
headline2: GoogleFonts.openSans(
fontSize: 59,
fontWeight: FontWeight.w300,
letterSpacing: -0.5
),
headline3: GoogleFonts.openSans(
fontSize: 48,
fontWeight: FontWeight.w400
),
headline4: GoogleFonts.openSans(
fontSize: 34,
fontWeight: FontWeight.w400,
letterSpacing: 0.25
),
headline5: GoogleFonts.openSans(
fontSize: 24,
fontWeight: FontWeight.w400
),
headline6: GoogleFonts.openSans(
fontSize: 20,
fontWeight: FontWeight.w500,
letterSpacing: 0.15
),
subtitle1: GoogleFonts.openSans(
fontSize: 16,
fontWeight: FontWeight.w400,
letterSpacing: 0.15
),
subtitle2: GoogleFonts.openSans(
fontSize: 14,
fontWeight: FontWeight.w500,
letterSpacing: 0.1
),
bodyText1: GoogleFonts.openSans(
fontSize: 18,
fontWeight: FontWeight.w400,
letterSpacing: 0.5
),
bodyText2: GoogleFonts.openSans(
fontSize: 16,
fontWeight: FontWeight.w400,
letterSpacing: 0.25
),
button: GoogleFonts.openSans(
fontSize: 14,
fontWeight: FontWeight.w500,
letterSpacing: 1.25
),
caption: GoogleFonts.openSans(
fontSize: 12,
fontWeight: FontWeight.w400,
letterSpacing: 0.4
),
overline: GoogleFonts.openSans(
fontSize: 10,
fontWeight: FontWeight.w400,
letterSpacing: 1.5
),
)
 */
