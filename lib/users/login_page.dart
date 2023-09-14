import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/users/reset_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/control/auth_controller.dart';
import 'package:firebase_login/users/signup_page.dart';

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
  @override
  void dispose() {
    _nikController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                  "Hello",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Sign into your Account",
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
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
                          hintText: "Your email",
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
                          hintText: "Password",
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
                        'Forgot Password?',
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
            height: 70,
          ),
          GestureDetector(
            onTap: (_signIn),
            //   try {
            //     // Perform Firebase sign-in with email and password.
            //     await FirebaseAuth.instance.signInWithEmailAndPassword(
            //       email:
            //           "zhaqianroufa@gmail.com", // Replace with the actual email.
            //       password: "123456", // Replace with the actual password.
            //     );

            //     // If sign-in is successful, navigate to WelcomePage.
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => WelcomePage(),
            //         ));
            //   } catch (e) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         backgroundColor: Colors.redAccent,
            //         content: Text('Sign-in error: $e'),
            //         duration: Duration(seconds: 3), // Durasi tampilan pesan
            //       ),
            //     );
            //   }
            // },
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
                  "Sign In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: w * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dont have an account?",
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
                  "  Sign Up",
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
          //   text: TextSpan(
          //     text: "Don't have an account? ",
          //     style: TextStyle(color: Colors.grey[500], fontSize: 15),
          //     children: [
          //       TextSpan(
          //         text: "Create Account",
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 15,
          //           fontWeight: FontWeight.bold,
          //         ),
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () => Get.to(() => SignUpPage()),
          //       ),
          //     ],
          //   ),
          // )
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
      // Jika berhasil, tampilkan SnackBar dengan warna hijau
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully Signin"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, "/home");
    } else {
      // Jika gagal, tampilkan SnackBar dengan warna merah
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email or Password Incorrect"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}