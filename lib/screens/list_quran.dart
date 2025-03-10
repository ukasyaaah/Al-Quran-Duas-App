import 'package:flutter/material.dart';
import 'package:flutter_alquran/screens/detail_surah.dart';
import 'package:flutter_alquran/services/quran_service.dart';


class SurahListScreen extends StatefulWidget {
  @override
  _SurahListScreenState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<dynamic>> surahList;

  @override
  void initState() {
    super.initState();
    surahList = QuranService.getSurahList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Surah')),
      body: FutureBuilder<List<dynamic>>(
        future: surahList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan!'));
          } else {
            final surahList = snapshot.data!;
            return ListView.builder(
              itemCount: surahList.length,
              itemBuilder: (context, index) {
                final surah = surahList[index];
                return ListTile(
                  title: Text('${surah['nomor']}. ${surah['nama_latin']}'),
                  subtitle: Text(surah['arti']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SurahDetailScreen(id: surah['nomor']),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
