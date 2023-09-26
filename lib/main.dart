import 'package:cdc_app/admin/admin_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cdc_app/page/home_page.dart';
import 'package:cdc_app/page/list_page.dart';
import 'package:cdc_app/otp/otp_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:cdc_app/auth_controller.dart';
import 'package:cdc_app/page/splash_screen.dart';
import 'package:cdc_app/page/welcome_page.dart';
import 'package:cdc_app/users/login_page.dart';
import 'package:cdc_app/users/signup_page.dart';

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
        '/home': (context) => MyHomePage(),
        '/list': (context) => ListPage(),
        '/admin': (context) => AdminPage(),
      },
    );
  }
}
