import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_alquran/widgets/color.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class SurahDetailScreen extends StatefulWidget {
  final int id;
  const SurahDetailScreen({super.key, required this.id});

  @override
  _SurahDetailScreenState createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late Future<Map<String, dynamic>> surahDetail;

  Future<Map<String, dynamic>> fetchSurahDetail() async {
    final response = await http.get(
      Uri.parse('https://quran-api.santrikoding.com/api/surah/${widget.id}'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data surah');
    }
  }

  @override
  void initState() {
    super.initState();
    surahDetail = fetchSurahDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: MyColors.primary),
        ),
        title: Text('Detail Surah'),
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        // toolbarHeight: 300,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            gradient: LinearGradient(
              colors: [MyColors.secondary, MyColors.ternary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: surahDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan!'));
          } else {
            final surah = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  '${surah['nama']}',
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  surah['arti'],
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20),
                ...surah['ayat'].map<Widget>((ayat) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${ayat['ar']}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.amiri(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: MyColors.text,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${ayat['idn']}',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16, color: MyColors.text),
                      ),
                      SizedBox(height: 25),
                      Divider(color: MyColors.secondary),
                      SizedBox(height: 15),
                    ],
                  );
                }).toList(),
              ],
            );
          }
        },
      ),
    );
  }
}
