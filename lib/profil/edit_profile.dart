import 'dart:convert';

import 'package:cdc_app/page/home_page.dart';
import 'package:cdc_app/profil/read.data.dart';
import 'package:flutter/material.dart';
import 'package:cdc_app/profil/settings.dart';
import 'package:http/http.dart ' as http;

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  List _listdata = [];
  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.10.2.81/cdc/read_profil.php'));

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  bool _obscureText = true;
  @override
  void initState() {
    _getdata();
    print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReadPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(
                    "Edit Profil",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                  ))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.blue,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: TextField(
                        controller: TextEditingController(
                            text: _listdata[index]['ufullname'] ?? ''),
                        // Ganti dengan controller yang sesuai
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Nama Lengkap',
                          // hintText: 'Your Name',
                        )
                        // TextEditingController(text: _listdata['ufullname'] ?? ''),
                        ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: TextField(
                      controller: TextEditingController(
                          text: _listdata[index]['uttl'] ?? ''),
                      // controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Tempat dan Tanggal Lahir',
                        // hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: TextField(
                      controller: TextEditingController(
                          text: _listdata[index]['unik'] ?? ''),
                      // _passwordController, // Ganti dengan controller yang sesuai
                      // Ini akan menyembunyikan teks
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'NIK',
                        // hintText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: TextField(
                      controller: TextEditingController(
                          text: _listdata[index]['ualamat'] ?? ''),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Alamat',
                        // hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: TextField(
                      controller: TextEditingController(
                          text: _listdata[index]['uemail'] ?? ''),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        // hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: TextField(
                      controller: TextEditingController(
                          text: _listdata[index]['utelepon'] ?? ''),
                      decoration: InputDecoration(
                        prefixText: '+62 ',
                        border: InputBorder.none,
                        labelText: 'Nomer Telepon',
                        // hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(color: Colors.grey[400]!),
                  //   ),
                  //   child: TextField(
                  //     controller: TextEditingController(
                  //         text: _listdata[index]['upassword'] ?? ''),
                  //     obscureText: _obscureText,
                  //     decoration: InputDecoration(
                  //       suffixIcon: togglePassword(),
                  //       border: InputBorder.none,

                  //       labelText: 'Kata Sandi',
                  //       // hintText: 'Enter your email',
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: TextField(
                      controller: TextEditingController(
                          text: _listdata[index]['level'] ?? ''),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Level',
                        // hintText: 'Enter your email',
                      ),
                    ),
                  ),

                  // buildTextField("Full Name", "Your Name", false),
                  // buildTextField("E-mail", "Your Email", false),
                  // buildTextField("Password", "Password", true),
                  // buildTextField("Location", "NIK", false),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "BATAL",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "SIMPAN",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon:
            _obscureText ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        color: Colors.grey);
  }
}
