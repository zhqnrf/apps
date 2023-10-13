import 'package:cdc_app/profil/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cdc_app/control/auth_controller.dart';
import 'package:cdc_app/otp/otp_form.dart';
import 'package:flutter/gestures.dart';
import 'package:cdc_app/profil/edit_profile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart ' as http;

// import 'form_container_widget.dart';

import 'package:cdc_app/users/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _ttlController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _levelController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _teleponController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String verificationID = "";

  Future<void> insertrecord() async {
    if (_fullnameController.text != "" ||
        _ttlController != " " ||
        _nikController.text != " " ||
        _alamatController != " " ||
        _emailController != " " ||
        _teleponController != " " ||
        _levelController != " " ||
        _passwordController.text != "") {
      try {
        String uri = "http://10.10.2.81/cdc/insert_register.php";
        var res = await http.post(Uri.parse(uri), body: {
          "fullname": _fullnameController.text,
          "ttl": _ttlController.text,
          "nik": _nikController.text,
          "alamat": _alamatController.text,
          "email": _emailController.text,
          "telepon": _teleponController.text,
          "password": _passwordController.text,
          "level": _levelController.text
        });
        var response = jsonDecode(res.body);
        if (response["succes"] == "true") {
          print("Record Inserted");
          _fullnameController.text = '';
          _ttlController.text = '';
          _nikController.text = '';
          _alamatController.text = '';
          _emailController.text = '';
          _teleponController.text = '';
          _passwordController.text = '';
          _levelController.text = '';
        } else {
          print("Some Error Expected");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill all Fields");
    }
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _ttlController.dispose();
    _nikController.dispose();
    _alamatController.dispose();
    _emailController.dispose();
    _teleponController.dispose();
    _passwordController.dispose();
    _levelController.dispose();
    // _nikController.dispose();
    // _emailController.dispose();
    // _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List images = ["g.png", "f.png", "t.png"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/signup.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.17,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: 41,
                      backgroundImage: AssetImage("img/profile1.png"),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Daftar",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Buat akun Baru",
                        style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      )
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Hello",
                    //   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    // ),
                    // Text(
                    //   "Sign into your Account",
                    //   style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    // ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          controller: _fullnameController,
                          decoration: InputDecoration(
                              hintText: "Nama Anda",
                              prefixIcon: Icon(Icons.perm_identity,
                                  color: Colors.blueAccent),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          controller: _ttlController,
                          decoration: InputDecoration(
                              hintText: "Tempat dan Tanggal Lahir",
                              prefixIcon: Icon(Icons.date_range_rounded,
                                  color: Colors.blueAccent),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          controller: _nikController,
                          decoration: InputDecoration(
                              hintText: "NIK",
                              prefixIcon: Icon(Icons.card_membership,
                                  color: Colors.blueAccent),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                        hintText: "Alamat ",
                        prefixIcon: Icon(Icons.place, color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  )),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  )),
              SizedBox(
                height: 15,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(30),
              //       boxShadow: [
              //         BoxShadow(
              //             blurRadius: 10,
              //             spreadRadius: 7,
              //             offset: Offset(1, 1),
              //             color: Colors.grey.withOpacity(0.2))
              //       ]),
              //   child: TextField(
              //     controller: _phoneController,
              //     decoration: InputDecoration(
              //       hintText: "Your Phone",

              //       prefixIcon:
              //           Icon(Icons.phone, color: Colors.blueAccent),
              //       prefixText: "+62 ",
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //         borderSide:
              //             BorderSide(color: Colors.white, width: 1.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //         borderSide:
              //             BorderSide(color: Colors.white, width: 1.0),
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //       counterText:
              //           "", // Untuk menyembunyikan jumlah karakter yang tersisa
              //     ),
              //     keyboardType: TextInputType.phone,
              //     maxLength: 11, // Tempatkan max length di sini
              //   ),
              // ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                    controller: _teleponController,
                    decoration: InputDecoration(
                        hintText: "Nomor Telepon",
                        prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                        prefixText: '+62 ',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  )),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Kata Sandi",
                        prefixIcon: Icon(Icons.password_rounded,
                            color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  )),

              SizedBox(
                height: 15,
              ),

              // Container(
              //   margin: const EdgeInsets.only(left: 20, right: 20),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(30),
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 10,
              //         spreadRadius: 7,
              //         offset: Offset(1, 1),
              //         color: Colors.grey.withOpacity(0.2),
              //       ),
              //     ],
              //   ),
              //   child: TextField(
              //     controller: _levelController,
              //     decoration: InputDecoration(
              //       hintText: "Level",
              //       prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //         borderSide: BorderSide(color: Colors.white, width: 1.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //         borderSide: BorderSide(color: Colors.white, width: 1.0),
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //     ),
              //   ),
              // ),
              // //   FirebaseAuth.instance.checkActionCode(
              //       _emailController.text.trim(),
              //       _nikController.text.trim(),
              //       _passwordController.text.trim());
              // },

              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () async {
                  _signUp();
                  insertrecord();

                  // Navigasi ke halaman OTPForm sambil mengirim nilai _teleponController
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          OTPForm(telepon: _teleponController.text),
                    ),
                  );
                }, // Warna latar belakang tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Bentuk tombol
                ),
                child: Container(
                  width: w * 0.4,
                  height: h * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage("img/loginbtn.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: w * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah Punya Akun? ",
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 22),
            ],
          ),
        ));
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String level = _levelController.text
        .toLowerCase(); // Ambil nilai level dan konversi ke huruf kecil

    if (level == 'admin' || level == 'member') {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        print("User is successfully created");
        // Anda dapat menyimpan nilai level ke database atau melakukan sesuatu sesuai kebutuhan di sini
        // Misalnya, jika Anda memiliki kolom "level" di database, simpan nilai level ke sana.
        // Selanjutnya, Anda dapat menggunakannya untuk mengelompokkan pengguna atau memberi izin akses sesuai level.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      } else {
        print("Some error happened");
      }
    } else {
      // Jika level yang dimasukkan tidak valid (bukan "admin" atau "member")
      print("Invalid level. Please enter 'admin' or 'member'.");
    }
  }
}
