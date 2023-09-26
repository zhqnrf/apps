import 'package:flutter/material.dart';
import 'package:cdc_app/page/home_page.dart';

class ListPage extends StatelessWidget {
  final List<Alumni> alumniList = [
    Alumni(name: "Zhaqian Rouf", graduationYear: 2020),
    Alumni(name: "Aleandra Bima", graduationYear: 2024),
    Alumni(name: "Fahim David", graduationYear: 2023),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alumni",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
              // Implement logic for logout here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: alumniList.length,
        itemBuilder: (context, index) {
          final alumni = alumniList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple.shade100,
              backgroundImage: AssetImage(
                  'img/profile.png'), // Ganti dengan gambar profil alumni
            ),
            title: Text(alumni.name),
            subtitle: Text("Lulus tahun ${alumni.graduationYear}"),
          );
        },
      ),
    );
  }
}

class Alumni {
  final String name;
  final int graduationYear;

  Alumni({
    required this.name,
    required this.graduationYear,
  });
}
