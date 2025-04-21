import 'package:flutter/material.dart';
import 'package:flutter_alquran/screens/list_doa.dart';
import 'package:flutter_alquran/screens/list_quran.dart';
import 'package:flutter_alquran/screens/profile.dart';

import 'package:flutter_alquran/screens/splash_screen.dart';
import 'package:flutter_alquran/widgets/color.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Map<String, dynamic>> kategori = [
    {
      'nama': 'Quran',
      'gambar': 'assets/images/quran.png',
      'warna': 0xffF5FAF4,
      'pojok': 'assets/images/pojokquran.png',
    },
    {
      'nama': 'Duas',
      'gambar': 'assets/images/duas.png',
      'warna': 0xffF5F6FD,
      'pojok': 'assets/images/pojokduas.png',
    },
    {
      'nama': 'Info',
      'gambar': 'assets/images/info.png',
      'warna': 0xffFFFAF0,
      'pojok': 'assets/images/pojokinfo.png',
    },
  ];

  List<Map<String, dynamic>> page = [
    {'pages': SurahListScreen()},
    {'pages': ListDoaPage()},
    {'pages': ProfilePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.primary,
        title: Text(
          'Hafiz',

          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: MyColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/Vector1.png'),
                  ),
                  borderRadius: BorderRadius.circular(23),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [MyColors.secondary, MyColors.ternary],
                  ),
                ),
                width: 345,
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assalamualaikum,',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: MyColors.primary,
                              ),
                            ),
                            Text(
                              'Siap ngaji hari ini?',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: MyColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width *
                            0.3, // 20% dari lebar layar
                        height:
                            MediaQuery.of(context).size.width *
                            0.3, // 20% dari lebar layar (supaya proporsional)
                        child: Image.asset(
                          'assets/images/splash.png',
                          fit: BoxFit.contain, // Biar nggak kepotong
                        ),
                      ),

                      // Image.asset('assets/images/splash.png'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 33),
              Text(
                'Popular',
                style: GoogleFonts.poppins(
                  color: MyColors.text,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 31),
              SizedBox(
                height: 400,
                child: GridView.builder(
                  // shrinkWrap: true,x
                  scrollDirection: Axis.vertical,
                  itemCount: kategori.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 163,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 24,
                  ),
                  itemBuilder:
                      (context, index) => GestureDetector(
                        onTap:
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (BuildContext context) =>
                                        (page[index]['pages']),
                              ),
                            ),
                        child: Container(
                          width: 163,
                          height: 163,
                          decoration: BoxDecoration(
                            color: Color(kategori[index]['warna']),
                            borderRadius: BorderRadius.circular(23),
                            image: DecorationImage(
                              alignment: Alignment.bottomRight,
                              fit: BoxFit.fitWidth,

                              image: AssetImage(kategori[index]['pojok']),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kategori[index]['nama'],
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.text,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.contain,
                                      kategori[index]['gambar'],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
