import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_alquran/widgets/color.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../models/surah.dart';

class SurahDetailScreen extends StatefulWidget {
  final int id;
  const SurahDetailScreen({super.key, required this.id});

  @override
  _SurahDetailScreenState createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late Future<Surah> surahDetail;

  Future<Surah> detailSurah() async {
    final response = await http.get(
      Uri.parse('https://equran.id/api/v2/surat/${widget.id}'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return Surah.fromJson(data);
    } else {
      throw Exception('Gagal mengambil data surah');
    }
  }

  @override
  void initState() {
    super.initState();
    surahDetail = detailSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: MyColors.primary),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)
            // ),
            image: DecorationImage(
              opacity: 0.5,
              alignment: Alignment.bottomCenter,
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/Vector1.png'),
            ),
            gradient: LinearGradient(
              colors: [MyColors.secondary, MyColors.ternary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: FutureBuilder<Surah>(
          future: surahDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColors.ternary,
                  backgroundColor: MyColors.text,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan!'));
            } else {
              final surah = snapshot.data!;
              return Text(
                surah.nama,
                style: GoogleFonts.amiri(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: MyColors.primary,
                ),
              );
            }
          },
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Tab(child: Image.asset('assets/images/bismillah.png')),
        ),
      ),

      body: FutureBuilder<Surah>(
        future: surahDetail,
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
            final surah = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: surah.ayat.length,
              itemBuilder: (context, index) {
                final ayat = surah.ayat[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      ayat.teksArab,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.amiri(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: MyColors.text,
                        height: 3,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      ayat.teksIndonesia,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16, color: MyColors.text),
                    ),
                    SizedBox(height: 25),
                    Divider(color: MyColors.secondary),
                    SizedBox(height: 15),
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
