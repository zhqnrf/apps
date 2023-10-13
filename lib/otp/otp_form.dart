import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPForm extends StatefulWidget {
  final String telepon;

  OTPForm({required this.telepon});

  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";

  @override
  void initState() {
    super.initState();
    // Isi nilai phoneController dengan nilai dari _teleponController
    phoneController.text = widget.telepon;
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verifikasi Akun",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 58, 146),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Nomor Telepon",
                prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                prefixText: '+62 ',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 1.0),
                ),
              ),
              maxLength: 11,
              keyboardType: TextInputType.phone,
            ),
            Visibility(
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(
                  hintText: 'OTP',
                  prefixIcon: Icon(Icons.code, color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 1.0),
                  ),
                ),
                maxLength: 6,
                keyboardType: TextInputType.number,
              ),
              visible: otpVisibility,
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                if (otpVisibility) {
                  verifyOTP();
                } else {
                  loginWithPhone();
                }
              },
              child: Container(
                width: w * 0.3,
                height: h * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage("img/loginbtn.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Verifikasi",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    String phoneNumber = "+62" + phoneController.text;
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushNamed(context, "/home");
        } else {
          Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }
}
