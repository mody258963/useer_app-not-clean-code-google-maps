import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:useer_app/login%20page/login.dart';

class ForigotPage extends StatefulWidget {
  const ForigotPage({super.key});

  @override
  State<ForigotPage> createState() => _ForigotPageState();
}

class _ForigotPageState extends State<ForigotPage> {
  Color? colorgray = const Color.fromARGB(255, 189, 189, 189);
  TextEditingController phoneconttroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwodconttroler = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future restpass() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailcontroller.text.trim());
        weekpass();
      } on FirebaseAuthException catch (e) {
        print(e);
        retryagan();
      }
    }
  }

  void weekpass() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const AlertDialog(
            content: Text("Email Sent "),
            title: Text("Check Your Email"),
          );
        });
  }

  void retryagan() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const AlertDialog(
            content: Text("Retry"),
            title: Text("Retry again later"),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 42,
                    left: 350,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/boba1.png',
                        height: height * 0.06,
                        width: width * 0.075,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 300,
                        bottom: 70,
                        top: 46,
                      ),
                      child: Text("Anbobtk",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.03)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        right: 70,
                      ),
                      child: Text(
                        "Oh, no !",
                        style: TextStyle(
                            fontSize: width * 0.16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 65,
                      ),
                      child: Text(
                        "I forgot",
                        style: TextStyle(
                            fontSize: width * 0.16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 380,
                            left: 35,
                            right: 60,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length > 40) {
                                return "Email is very long";
                              }
                              if (value.length < 7) {
                                return "Email is very short";
                              } else {
                                return null;
                              }
                            },
                            controller: emailcontroller,
                            maxLines: 1,
                            cursorColor: colorgray,
                            decoration: InputDecoration(
                              hintText: "Email",
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
                        padding: const EdgeInsets.only(
                            right: 25, top: 70, bottom: 200),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.77,
                          child: ElevatedButton(
                            onPressed: () {
                              restpass();
                            },
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.zero, right: Radius.zero),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              "Rest Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 100),
                          child: Text("Already have an account?",
                              style: TextStyle(
                                  color: colorgray as Color,
                                  fontSize: width * 0.03)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0.5,
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.035))),
                        )
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
