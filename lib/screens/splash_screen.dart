import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_alquran/screens/main_screen.dart';
import 'package:flutter_alquran/widgets/color.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 95, right: 26, left: 26),
              child: Container(
                width: 341,
                height: 411,
                decoration: BoxDecoration(
                  color: MyColors.secondary,

                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    image: AssetImage('assets/images/splash.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 22),
            Text(
              'Hafiz',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: MyColors.ternary,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Your Daily Quran and\nDuas Recite',

              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: MyColors.text,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
