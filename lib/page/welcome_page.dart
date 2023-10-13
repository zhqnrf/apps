import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_login/auth_controller.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_login/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
                    image: AssetImage("img/signup.png"), fit: BoxFit.cover)),
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
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 15,
                ),
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
            height: 70,
          ),
          Container(
            width: w,
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Anda akan keluar",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Text(
                  "Apakah anda yakin?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
            },
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
                  "Keluar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: w * 0.1),
        ],
      ),
    );
  }
}
