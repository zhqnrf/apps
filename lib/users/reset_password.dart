import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    // Implement your password reset logic here.
    String email = _emailController.text;

    // You should use Firebase Authentication's password reset functionality here.
    // Example:
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    // Provide user feedback, e.g., show a snackbar or navigate back to the login page.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password reset email sent to $email'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Email",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 58, 146),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Masukkan Email Anda',
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: w * 0.3,
              height: h * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage("img/loginbtn.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ElevatedButton(
                onPressed: _resetPassword,
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.transparent, // Menghilangkan warna latar belakang
                  elevation: 0, // Menghilangkan bayangan
                ),
                child: Text(
                  "Verifikasi",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
