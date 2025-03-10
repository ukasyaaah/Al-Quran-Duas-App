import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_alquran/screens/detail_doa.dart';
import 'package:http/http.dart' as http;

class ListDoaPage extends StatefulWidget {
  @override
  _ListDoaPageState createState() => _ListDoaPageState();
}

class _ListDoaPageState extends State<ListDoaPage> {
  List doaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoaList();
  }

  Future<void> fetchDoaList() async {
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/doa'),
    );

    print('Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      try {
        setState(() {
          doaList = json.decode(response.body);
          isLoading = false;
        });
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Error: Gagal mengambil data, status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Doa")),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: doaList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(doaList[index]['judul']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  DetailDoaPage(id: doaList[index]['id']),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
