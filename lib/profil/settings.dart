import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cdc_app/profil/edit_profile.dart';
import 'package:cdc_app/page/home_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Pengaturan",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Akun",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Pengaturan Profil"),
            buildAccountOptionRow(context, "Ubah Kata Sandi"),
            buildAccountOptionRow(context, "Tambah Pendidikan"),
            buildAccountOptionRow(context, "Tambah Pekerjaan"),
            buildAccountOptionRow(context, "Privacy and security"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifikasi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("Berita Terbaru", true),
            buildNotificationOptionRow("Aktivitas Akun", true),

            SizedBox(
              height: 50,
            ),
            // Center(
            //     child: OutlinedButton(
            //   style: OutlinedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(horizontal: 40),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            //   onPressed: () {},
            //   child: Text(
            //     "SIGN OUT",
            //     style: TextStyle(
            //       fontSize: 16,
            //       letterSpacing: 2.2,
            //       color: Colors.black,
            //     ),
            //   ),
            // ))
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  // GestureDetector buildAccountOptionRow(BuildContext context, String title) {
  //   return GestureDetector(
  //     onTap: () {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text(title),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.of(context).pop(); // Tutup dialog
  //                     Navigator.push(
  //                       // Navigasi ke halaman profil
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => EditProfilePage(),
  //                       ),
  //                     );
  //                   },
  //                   child: Text(
  //                       "Profil Settings"), // Ganti dengan opsi profil Anda
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.of(context).pop(); // Tutup dialog
  //                     // Tambahkan navigasi untuk opsi lain jika diperlukan
  //                   },
  //                   child: Text("Option 2"),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.of(context).pop(); // Tutup dialog
  //                     // Tambahkan navigasi untuk opsi lain jika diperlukan
  //                   },
  //                   child: Text("Option 3"),
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text("Close"),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             title,
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w500,
  //               color: Colors.grey[600],
  //             ),
  //           ),
  //           Icon(
  //             Icons.arrow_forward_ios,
  //             color: Colors.grey,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Pengaturan Profil") {
          // Hanya untuk "Profil Settings"
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfilePage(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Tutup dialog
                        // Tambahkan navigasi untuk opsi lain jika diperlukan
                      },
                      child: Text("Option 2"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Tutup dialog
                        // Tambahkan navigasi untuk opsi lain jika diperlukan
                      },
                      child: Text("Option 3"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
