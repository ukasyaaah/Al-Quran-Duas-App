import 'package:flutter/material.dart';
import 'package:flutter_alquran/widgets/color.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        title: Text(' About Hafiz App', textAlign: TextAlign.center),
        centerTitle: true,
      ),

      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                // height: 400,
                decoration: BoxDecoration(
                  color: MyColors.ternary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ukhasyah Fauzan',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Software Engineer',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Hai! Aku Ukhasyah, pengembang aplikasi ini. Desain aplikasi ini terinspirasi dari karya keren milik Syeda Urooj Sohail. \nSemoga aplikasinya bermanfaat dan nyaman dipakai, ya!',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          height: 2,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
