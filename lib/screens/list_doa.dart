import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_alquran/models/doa.dart';
import 'package:flutter_alquran/screens/detail_doa.dart';
import 'package:flutter_alquran/widgets/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ListDoaPage extends StatefulWidget {
  @override
  _ListDoaPageState createState() => _ListDoaPageState();
}

class _ListDoaPageState extends State<ListDoaPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoaList();
  }

  Future<List<dynamic>> fetchDoaList() async {
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/doa'),
    );

    if (response.statusCode == 200) {
      List doaList = json.decode(response.body);
      return doaList.map((json) => Doa.fromJson(json)).toList();
      // isLoading = false;
    } else {
      throw Exception('Gagal Parsing Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        centerTitle: true,
        title: Text(
          "Daftar Doa",
          style: GoogleFonts.poppins(
            color: MyColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchDoaList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.ternary,
                backgroundColor: MyColors.text,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Kamu ga punya koneksi internet'),
            );
          } else {
            List<dynamic> listDoa = snapshot.data!;
            return ListView.builder(
              itemCount: listDoa.length,
              itemBuilder: (context, index) {
                final doa = listDoa[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 36,
                        height: 36,
                        child: Text(
                          '${doa.id}',
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
                        doa.judul,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: MyColors.text,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailDoaPage(id: doa.id),
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
