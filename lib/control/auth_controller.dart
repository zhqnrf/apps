import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_login/login_page.dart';
// import 'package:firebase_login/welcome_page.dart';

// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
//   late Rx<User?> _user;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   void onReady() {
//     super.onReady();
//     _user = Rx<User?>(auth.currentUser);

//     _user.bindStream(auth.userChanges());
//     ever(_user, _initialScreen);
//   }

//   _initialScreen(User? user) {
//     if (user == null) {
//       print("login page");
//       Get.offAll(() => LoginPage());
//     } else {
//       Get.offAll(() => WelcomePage());
//     }
//   }

//   void register(String email, String nik, String password) async {
//     try {
//       await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {
//       Get.snackbar("Account Creation Error", e.toString(),
//           backgroundColor: Colors.redAccent,
//           snackPosition: SnackPosition.BOTTOM,
//           titleText: Text(
//             "Account Creation Failed",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ));
//     }
//   }
// }


