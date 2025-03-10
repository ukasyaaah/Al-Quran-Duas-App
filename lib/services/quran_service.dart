import 'dart:convert';
import 'package:http/http.dart' as http;

class QuranService {
  static const String baseUrl = 'https://quran-api.santrikoding.com/api';


  static Future<List<dynamic>> getSurahList() async {
    final response = await http.get(Uri.parse('$baseUrl/surah'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data surah');
    }
  }
}
