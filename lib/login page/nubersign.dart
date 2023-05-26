import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:useer_app/app%20settings/dumyboutton.dart';
import 'package:useer_app/login%20page/global.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  Color? colorgray = Color.fromARGB(255, 189, 189, 189);
  String verfyId = "";

  Future<void> signupWithnumber() async {
    try {
      await fAuth.verifyPhoneNumber(
        phoneNumber: '+20$phoneconttroller',
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential.verificationId);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          verfyId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (ex) {
      print(ex);
    }
  }

  TextEditingController phoneconttroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 350,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/boba1.png',
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 260,
                      bottom: 70,
                      top: 62,
                    ),
                    child: Text("Anbobtk",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                      right: 230,
                    ),
                    child: Text(
                      "Hi !",
                      style:
                          TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 85,
                    ),
                    child: Text(
                      "  Welcome",
                      style:
                          TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 350,
                            left: 35,
                            right: 60,
                          ),
                          child: TextFormField(
                            controller: phoneconttroller,
                            maxLines: 1,
                            cursorColor: colorgray,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              enabledBorder: UnderlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(
                                    width: 2.3, color: colorgray as Color),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: colorgray as Color, width: 3.8),
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 25, top: 150),
                        child: Xbutton(
                            text: "                             Sign Up",
                            icons: Icon(Icons.arrow_forward),
                            page: signupWithnumber()),
                      ),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 167.5),
                          child: Text(
                              "                 Already have an account?",
                              style: TextStyle(color: colorgray as Color)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 163,
                          ),
                          child: TextButton(
                              onPressed: () {},
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                        )
                      ])
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
