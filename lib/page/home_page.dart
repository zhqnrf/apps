import 'package:cdc_app/page/welcome_page.dart';
import 'package:cdc_app/profil/settings.dart';
import 'package:cdc_app/users/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cdc_app/profil/edit_profile.dart';
import 'package:cdc_app/page/list_page.dart';
import 'dart:io';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? editedFotoProfil;
  // final TextEditingController _fullnameController = TextEditingController();
  // final TextEditingController _ttlController = TextEditingController();
  // final TextEditingController _nikController = TextEditingController();
  // final TextEditingController _alamatController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _teleponController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Hello Name!',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Temukan Ceritamu',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.white54),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white70),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 30,
                        backgroundImage: editedFotoProfil != null
                            ? FileImage(editedFotoProfil!)
                            : AssetImage("img/profile1.png") as ImageProvider,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard(
                      'Informasi', CupertinoIcons.info_circle, Colors.indigo),
                  itemDashboard(
                      'Kuesioner', CupertinoIcons.graph_circle, Colors.green),
                  itemDashboard(
                      'Alumni', CupertinoIcons.person_2, Colors.purple),
                  itemDashboard(
                      'Chat', CupertinoIcons.chat_bubble, Colors.brown),
                  itemDashboard(
                      'Sharing', CupertinoIcons.pencil_outline, Colors.teal),
                  itemDashboard(
                      'Tentang', CupertinoIcons.question_circle, Colors.blue),
                  // itemDashboard(
                  //     'Contact', CupertinoIcons.phone, Colors.pinkAccent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) =>
      GestureDetector(
          onTap: () {
            if (title == 'List') {
              // Pindah ke halaman ListPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage()),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      color: Theme.of(context).primaryColor.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 5)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(iconData, color: Colors.white)),
                const SizedBox(height: 8),
                Text(title.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
          ));
}
