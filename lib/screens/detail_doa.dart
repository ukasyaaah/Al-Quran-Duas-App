import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DetailDoaPage extends StatefulWidget {
  final int id;
  DetailDoaPage({required this.id});

  @override
  _DetailDoaPageState createState() => _DetailDoaPageState();
}

class _DetailDoaPageState extends State<DetailDoaPage> {
  Map<String, dynamic>? doaDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetailDoa();
  }

  Future<void> fetchDetailDoa() async {
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/doa/${widget.id}'),
    );

    if (response.statusCode == 200) {
      try {
        setState(() {
          doaDetail = jsonDecode(response.body);
          isLoading = false;
        });
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Error: Gagal mengambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Doa")),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      doaDetail?['judul'] ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,

                      doaDetail?['arab'] ?? '',
                      style: GoogleFonts.amiri(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,

                      doaDetail?['latin'] ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,

                      doaDetail?['terjemah'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
    );
  }
}
