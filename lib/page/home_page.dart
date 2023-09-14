import 'package:firebase_login/users/login_page.dart';
import 'package:firebase_login/users/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_login/page/list_page.dart';
// import 'package:firebase_login/users/profile_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_login/users/login_page.dart';
// import 'package:firebase_login/users/profile_page.dart';
// import 'package:firebase_login/page/list_page.dart';
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
      home: MyHomePage(
        onProfileImageChanged: (newImage) {
          // Callback ini akan dipanggil saat gambar profil diubah di ProfilePage
          // Anda dapat memperbarui editedFotoProfil dengan gambar yang baru
          if (newImage != null) {
            // Tambahkan logika untuk mengubah gambar profil di sini jika diperlukan
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(File?) onProfileImageChanged;

  const MyHomePage({required this.onProfileImageChanged});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? editedFotoProfil;

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
                  builder: (context) => LoginPage(),
                ),
              );
              // Implement logic for logout here
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
                    'Hello !',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Find your journey',
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
                          builder: (context) => ProfilePage(
                            onProfileImageChanged: (newImage) {
                              // Callback ini akan dipanggil saat gambar profil diubah di ProfilePage
                              // Anda dapat memperbarui editedFotoProfil dengan gambar yang baru
                              if (newImage != null) {
                                setState(() {
                                  editedFotoProfil = newImage;
                                });
                              }
                            },
                          ),
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
                      'Tracks', CupertinoIcons.graph_circle, Colors.green),
                  itemDashboard('List', CupertinoIcons.person_2, Colors.purple),
                  itemDashboard(
                      'Activities', CupertinoIcons.graph_square, Colors.brown),
                  itemDashboard(
                      'Upload', CupertinoIcons.add_circled, Colors.teal),
                  itemDashboard(
                      'About', CupertinoIcons.question_circle, Colors.blue),
                  itemDashboard(
                      'Contact', CupertinoIcons.phone, Colors.pinkAccent),
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

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Dashboard',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('Dashboard'),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => LoginPage(),
//                 ),
//               );
//               // Implement logic for logout here
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: const BorderRadius.only(
//                 bottomRight: Radius.circular(50),
//               ),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 50),
//                 ListTile(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 30),
//                   title: Text(
//                     'Hello !',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         ?.copyWith(color: Colors.white),
//                   ),
//                   subtitle: Text(
//                     'Find your journey',
//                     style: Theme.of(context)
//                         .textTheme
//                         .subtitle1
//                         ?.copyWith(color: Colors.white54),
//                   ),
//                   trailing: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProfilePage(),
//                         ),
//                       );
//                       // Navigasi ke halaman profil di sini
//                     },
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white70,
//                       radius: 30,
//                       backgroundImage: AssetImage("img/profile1.png"),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30)
//               ],
//             ),
//           ),
//           Container(
//             color: Theme.of(context).primaryColor,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:
//                       BorderRadius.only(topLeft: Radius.circular(200))),
//               child: GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 40,
//                 mainAxisSpacing: 30,
//                 children: [
//                   itemDashboard(
//                       'Informasi', CupertinoIcons.info_circle, Colors.indigo),
//                   itemDashboard(
//                       'Tracks', CupertinoIcons.graph_circle, Colors.green),
//                   itemDashboard('List', CupertinoIcons.person_2, Colors.purple),
//                   itemDashboard(
//                       'Activities', CupertinoIcons.graph_square, Colors.brown),
//                   itemDashboard(
//                       'Upload', CupertinoIcons.add_circled, Colors.teal),
//                   itemDashboard(
//                       'About', CupertinoIcons.question_circle, Colors.blue),
//                   itemDashboard(
//                       'Contact', CupertinoIcons.phone, Colors.pinkAccent),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20)
//         ],
//       ),
//     );
//   }

//   itemDashboard(String title, IconData iconData, Color background) =>
//       GestureDetector(
//           onTap: () {
//             if (title == 'List') {
//               // Pindah ke halaman ListPage
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ListPage()),
//               );
//             }
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                       offset: const Offset(0, 5),
//                       color: Theme.of(context).primaryColor.withOpacity(.2),
//                       spreadRadius: 2,
//                       blurRadius: 5)
//                 ]),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: background,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(iconData, color: Colors.white)),
//                 const SizedBox(height: 8),
//                 Text(title.toUpperCase(),
//                     style: Theme.of(context).textTheme.titleMedium)
//               ],
//             ),
//           ));
// }
