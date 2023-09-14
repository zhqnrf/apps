import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/control/auth_controller.dart';
import 'package:firebase_login/otp/otp_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart ' as http;

// import 'form_container_widget.dart';

import 'package:firebase_login/users/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  // TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String verificationID = "";

  Future<void> insertrecord() async {
    if (_nameController.text != "" ||
        _nikController.text != " " ||
        _emailController != " " ||
        _passwordController.text != "") {
      try {
        String uri = "http://10.0.2.2/login_mysql/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": _nameController.text,
          "nik": _nikController.text,
          "email": _emailController.text,
          "password": _passwordController.text
        });
        var response = jsonDecode(res.body);
        if (response["succes"] == "true") {
          print("Record Inserted");
          _nameController.text = '';
          _nikController.text = '';
          _emailController.text = '';
          _passwordController.text = '';
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
    _nikController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                        "Register",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Make your new Account",
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
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
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: "Your Name",
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
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: "Your Email",
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.blueAccent),
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

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(),
                    //     ),
                    //     Text(
                    //       "Forgot Password?",
                    //       style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    //     )
                    //   ],
                    // ),
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
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
                height: 25,
              ),
              //   FirebaseAuth.instance.checkActionCode(
              //       _emailController.text.trim(),
              //       _nikController.text.trim(),
              //       _passwordController.text.trim());
              // },
              MaterialButton(
                onPressed: () {
                  _signUp();
                  insertrecord();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

// child: Container(
              //   width: w * 0.5,
              //   height: h * 0.08,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     image: DecorationImage(
              //       image: AssetImage("img/loginbtn.png"),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   child: Center(
              //     child: Text(
              //       "Sign Up",
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(height: w * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
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
                      "  Sign In",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // RichText(
              //     text: TextSpan(
              //         text: "Have an account? ",
              //         style: TextStyle(color: Colors.grey[500], fontSize: 15),
              //         children: [
              //       TextSpan(
              //         text: "Sign in",
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold),
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () => Get.to(() => LoginPage()),
              //       )
              //     ])),
              SizedBox(height: w * 0.02),
              // Wrap(
              //   children: List<Widget>.generate(3, (index) {
              //     return Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: CircleAvatar(
              //         radius: 20,
              //         backgroundColor: Colors.grey[500],
              //         child: CircleAvatar(
              //           radius: 30,
              //           backgroundImage: AssetImage("img/" + images[index]),
              //         ),
              //       ),
              //     );
              //   }),
              // )
            ],
          ),
        ));
  }

  // void loginWithPhone() async {
  //   auth.verifyPhoneNumber(
  //     phoneNumber: "+62" + _phoneController.text,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential).then((value) {
  //         print("You are logged in successfully");
  //       });
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print(e.message);
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       verificationID = verificationId;
  //       setState(() {});
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

  void _signUp() async {
    // String nik = _nikController.text;
    // String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
      Navigator.pushNamed(context, "/otpform");
    } else {
      print("Some error happend");
    }
  }
}
