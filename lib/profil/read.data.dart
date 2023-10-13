import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReadPage extends StatefulWidget {
  const ReadPage({Key? key});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  List<Map<String, dynamic>> _listdata = [];
  bool _isLoading = true;

  Future<void> _getData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.10.2.81/cdc/read_profil.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      } else {
        // Tampilkan pesan kesalahan jika diperlukan
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Tampilkan pesan kesalahan jika diperlukan
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Indikator Loading
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      _listdata[index]['ufullname'] ??
                          '', // Ganti dengan key yang sesuai
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
