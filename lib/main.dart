import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/page/home_page.dart';
import 'package:firebase_login/page/list_page.dart';
import 'package:firebase_login/otp/otp_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_login/auth_controller.dart';
import 'package:firebase_login/page/splash_screen.dart';
import 'package:firebase_login/page/welcome_page.dart';
import 'package:firebase_login/users/login_page.dart';
import 'package:firebase_login/users/signup_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCWVRoJ4A0MhCUUj_ZqjF2JGJbMHM-o69I",
        appId: "1:448813136954:android:6d70636a8a5cfbb367c903",
        messagingSenderId: "448813136954",
        projectId: "fir-getx-app-18f6a",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Firebase',
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/welcome': (context) => WelcomePage(),
        '/home': (context) => MyHomePage(
              onProfileImageChanged: (newImage) {
                // Callback ini akan dipanggil saat gambar profil diubah di ProfilePage
                // Anda dapat memperbarui editedFotoProfil dengan gambar yang baru
                if (newImage != null) {
                  // Tambahkan logika untuk mengubah gambar profil di sini jika diperlukan
                }
              },
            ),
        '/list': (context) => ListPage(),
        '/otpform': (context) => LoginScreen(),
      },
    );
  }
}
