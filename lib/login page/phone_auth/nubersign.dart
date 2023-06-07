import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:useer_app/login%20page/global.dart';
import 'package:useer_app/login%20page/phone_auth/verfyScreen.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});
  static String verfyId = "";

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  Color? colorgray = const Color.fromARGB(255, 189, 189, 189);

  Future<void> signupWithnumber() async {
    try {
      await fAuth.verifyPhoneNumber(
        phoneNumber: '+20${phoneconttroller.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential.verificationId);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          Phoneauth.verfyId = verificationId;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => verfyOPT(
                        verificationId: verificationId,
                      )));
          print("code sent====================");
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
              const Column(
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
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.77,
                          child: ElevatedButton(
                            onPressed: () {
                              signupWithnumber();
                            },
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.zero, right: Radius.zero),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              "                             Sign Up",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
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
                              child: const Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                        )
                      ]),
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
