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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/images/profile.jpg',
                          ),
                        ),
                        title: Text('ukasyaaah'),
                        titleTextStyle: GoogleFonts.poppins(
                          color: MyColors.text,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: Text('Hey'),
                      ),
                      SizedBox(height: 30),
                      Text(
                        textAlign: TextAlign.start,
                        'Aplikasi ini dirancang untuk memudahkan kamu dalam membaca, memahami, dan menghafal Al-Qur\’an serta doa-doa harian.\n\n Dilengkapi dengan teks Al-Qur’an lengkap, terjemahan, serta kumpulan doa - doa, aplikasi ini menjadi teman ibadah yang praktis. Semoga bermanfaat dan membawa berkah',
                        style: GoogleFonts.poppins(fontSize: 20),
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
