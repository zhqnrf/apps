import 'package:firebase_auth/firebase_auth.dart';
import 'package:cdc_app/users/reset_password.dart';
import 'package:cdc_app/page/home_page.dart';
import 'dart:convert';
import 'package:cdc_app/admin/admin_home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cdc_app/control/auth_controller.dart';
import 'package:cdc_app/users/signup_page.dart';
import 'package:http/http.dart ' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  void dispose() {
    _nikController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInAndLogin() {
    _signIn();
    _login();
  }

  Future<void> _login() async {
    final Uri url = Uri.parse("http://10.10.2.81/cdc/login.php");
    final response = await http.post(
      url,
      body: {
        "email": _emailController.text,
        "password": _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Jika permintaan berhasil, respons dapat diakses di sini
      print("Response: ${response.body}");

      // Parse respons JSON dari server
      final datauser = json.decode(response.body);

      if (datauser.isNotEmpty) {
        if (datauser[0]['level'] == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin');
        } else if (datauser[0]['level'] == 'member') {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Handle kasus lain jika diperlukan
        }
      } else {
        // Handle jika respons kosong atau tidak sesuai format yang diharapkan
      }
    } else {
      // Jika terjadi kesalahan dalam permintaan HTTP
      print("Error: ${response.statusCode}");
      throw Exception("Failed to login");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            width: w,
            height: h * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/loginimg.png"), fit: BoxFit.cover)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CDC",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Masuk ke akun Anda",
                  style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                ),
                SizedBox(
                  height: 20,
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
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "Email Anda",
                          prefixIcon:
                              Icon(Icons.email, color: Colors.blueAccent),
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
                      obscureText: _obscureText,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Kata Sandi",
                          prefixIcon: Icon(Icons.password_outlined,
                              color: Colors.blueAccent),
                          suffixIcon: togglePassword(),
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
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: TextStyle(
                          color: Colors
                              .grey[400], // Ubah warna teks menjadi abu-abu
                          fontSize: 15, // Ubah ukuran font menjadi 10
                        ),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ResetScreen()),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () => _signInAndLogin(),
            child: Container(
              width: w * 0.5,
              height: h * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage("img/loginbtn.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: w * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Belum mempunyai akun? ",
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
                child: Text(
                  "Daftar",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
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

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully Signin"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, "/home");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email or Password Incorrect"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
