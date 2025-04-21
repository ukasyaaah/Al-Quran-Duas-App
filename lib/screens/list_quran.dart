import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alquran/models/surah.dart';
import 'package:flutter_alquran/screens/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_alquran/widgets/color.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahListScreen extends StatefulWidget {
  @override
  _SurahListScreenState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  Future<List<Surah>> getListSurah() async {
    final response = await http.get(
      Uri.parse('https://equran.id/api/v2/surat'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      return data.map((e) => Surah.fromJson(e)).toList();
    } else {
      throw Exception('Gagal load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        title: Text(
          'Daftar Surah',
          style: GoogleFonts.poppins(
            color: MyColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: MyColors.primary,
        // titleTextStyle:
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: getListSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.ternary,
                backgroundColor: MyColors.text,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Kamu butuh koneksi internet'));
          } else {
            List<Surah> surahList = snapshot.data!;
            return ListView.builder(
              itemCount: surahList.length,
              itemBuilder: (context, index) {
                final surah = surahList[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Container(
                        width: 36,
                        height: 36,
                        child: Text(
                          '${surah.nomor}',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColors.primary,
                          ),
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: MyColors.ternary,
                        ),
                      ),

                      title: Text(
                        surah.namaLatin,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: MyColors.text,
                        ),
                      ),
                      subtitle: Text(
                        surah.arti,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SurahDetailScreen(id: surah.nomor),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 21),
                    Divider(height: 1, color: Colors.grey),
                    SizedBox(height: 21),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
