import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final Function(File?) onProfileImageChanged;

  const ProfilePage({required this.onProfileImageChanged});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? nama = "Nama Anda";
  String? nik = "1234567890";
  String? email = "email@contoh.com";
  File? fotoProfil;
  String? lokasiTerkini = "Lokasi Terkini: Mendapatkan lokasi...";

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Muat data profil saat halaman pertama kali dibuka
    _dapatkanLokasiTerkini(); // Mendapatkan lokasi saat halaman pertama kali dibuka
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? "Nama Anda";
      nik = prefs.getString('nik') ?? "1234567890";
      email = prefs.getString('email') ?? "email@contoh.com";
      String? imagePath = prefs.getString('fotoProfil');
      if (imagePath != null && imagePath.isNotEmpty) {
        fotoProfil = File(imagePath);
      }
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', nama ?? "");
    await prefs.setString('nik', nik ?? "");
    await prefs.setString('email', email ?? "");
    if (fotoProfil != null) {
      await prefs.setString('fotoProfil', fotoProfil!.path);
    }
  }

  Future<void> _ambilFotoProfil() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // atau ImageSource.camera

    if (pickedFile != null) {
      setState(() {
        fotoProfil = File(pickedFile.path);
      });
    }
  }

  Future<void> _dapatkanLokasiTerkini() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        lokasiTerkini =
            "Lokasi Terkini: ${position.latitude}, ${position.longitude}";
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        lokasiTerkini = "Lokasi Terkini: Gagal mendapatkan lokasi";
      });
    }
  }

  void _ubahProfil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          nama: nama ?? "",
          nik: nik ?? "",
          email: email ?? "",
          fotoProfil: fotoProfil,
        ),
      ),
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        setState(() {
          nama = result['nama'] ?? nama;
          nik = result['nik'] ?? nik;
          email = result['email'] ?? email;
          fotoProfil = result['fotoProfil'];
        });
        _saveProfileData(); // Simpan perubahan ke SharedPreferences
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 160.0,
              height: 160.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: fotoProfil != null
                      ? FileImage(fotoProfil!)
                      : AssetImage('img/profile1.png') as ImageProvider,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ambilFotoProfil,
              child: Text('Ambil Foto Profil'),
            ),
            SizedBox(height: 20),
            Text(
              nama ?? "",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "NIK: ${nik ?? ""}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Email: ${email ?? ""}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              lokasiTerkini ?? "",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ubahProfil,
              child: Text('Ubah Profil'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String? nama;
  final String? nik;
  final String? email;
  final File? fotoProfil;

  EditProfilePage({
    required this.nama,
    required this.nik,
    required this.email,
    required this.fotoProfil,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  File? _editedFotoProfil;

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.nama ?? "";
    _nikController.text = widget.nik ?? "";
    _emailController.text = widget.email ?? "";
    _editedFotoProfil = widget.fotoProfil;
  }

  void _simpanPerubahan() {
    String newNama = _namaController.text;
    String newNik = _nikController.text;
    String newEmail = _emailController.text;

    Map<String, dynamic> result = {
      'nama': newNama,
      'nik': newNik,
      'email': newEmail,
      'fotoProfil': _editedFotoProfil,
    };

    Navigator.pop(context, result);
  }

  void _ambilFotoProfil() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // atau ImageSource.camera

    if (pickedFile != null) {
      setState(() {
        _editedFotoProfil = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 160.0,
              height: 160.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _editedFotoProfil != null
                      ? FileImage(_editedFotoProfil!)
                      : AssetImage('img/profile1.png') as ImageProvider,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ambilFotoProfil,
              child: Text('Ubah Foto Profil'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _nikController,
              decoration: InputDecoration(labelText: 'NIK'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _simpanPerubahan,
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ProfilePage extends StatefulWidget {
//   final Function(File?) onProfileImageChanged;

//   const ProfilePage({required this.onProfileImageChanged});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   String? nama = "Nama Anda";
//   String? nik = "1234567890";
//   String? email = "email@contoh.com";
//   File? fotoProfil;
//   String? lokasiTerkini = "Lokasi Terkini: Mendapatkan lokasi...";

//   Future<void> _ambilFotoProfil() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(
//         source: ImageSource.gallery); // atau ImageSource.camera

//     if (pickedFile != null) {
//       setState(() {
//         fotoProfil = File(pickedFile.path);
//       });

//       widget.onProfileImageChanged(fotoProfil);
//     }
//   }

//   Future<void> _dapatkanLokasiTerkini() async {
//     try {
//       // Untuk sementara, tetap gunakan lokasi default
//       setState(() {
//         lokasiTerkini = "Lokasi Terkini: Jakarta, Indonesia";
//       });
//     } catch (e) {
//       print("Error: $e");
//       setState(() {
//         lokasiTerkini = "Lokasi Terkini: Gagal mendapatkan lokasi";
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _dapatkanLokasiTerkini();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profil Saya'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: 160.0,
//               height: 160.0,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: fotoProfil != null
//                       ? FileImage(fotoProfil!)
//                       : AssetImage('img/profile1.png') as ImageProvider,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _ambilFotoProfil,
//               child: Text('Ubah Foto Profil'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               nama ?? "",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "NIK: ${nik ?? ""}",
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Email: ${email ?? ""}",
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               lokasiTerkini ?? "",
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
