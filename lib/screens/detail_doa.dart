import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alquran/models/doa.dart';
import 'package:flutter_alquran/widgets/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DetailDoaPage extends StatefulWidget {
  final int id;
  DetailDoaPage({required this.id});

  @override
  _DetailDoaPageState createState() => _DetailDoaPageState();
}

class _DetailDoaPageState extends State<DetailDoaPage> {
  Future<Map<String, dynamic>> detailDoa() async {
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/doa/${widget.id}'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal ambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        title: Text(
          "Detail Doa",
          style: GoogleFonts.poppins(
            color: MyColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: MyColors.primary,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: detailDoa(),
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
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Data doa ga ada'));
          } else {
            final doaa = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        doaa['judul'],
                        style: GoogleFonts.poppins(
                          color: MyColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        doaa['arab'],
                        textAlign: TextAlign.right,
                        style: GoogleFonts.amiri(
                          height: 3,
                          color: MyColors.text,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        doaa['terjemah'],
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          color: MyColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
