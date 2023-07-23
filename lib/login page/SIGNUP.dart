import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:useer_app/googleMapPage.dart';
import 'package:useer_app/login%20page/global.dart';
import 'package:useer_app/login%20page/login.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwodconttroler = TextEditingController();
  final conformpasswodconttroler = TextEditingController();
  Color? colorgray = const Color.fromARGB(255, 189, 189, 189);
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  void weekpass() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const AlertDialog(
            content: Text("The password is too weak"),
            title: Text("Week Password"),
          );
        });
  }

  void weekemail() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const AlertDialog(
        content: Text("Email is used before"),
        title: Text("Email invalid"),
      ),
    );
  }

  Future signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      if (passwordconfirmed()) {
        try {
          final User? firebaseUser =
              (await fAuth.createUserWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwodconttroler.text.trim(),
          ))
                  .user;
          if (firebaseUser != null) {
            Map driverMap = {
              "id": firebaseUser.uid,
              "name": namecontroller.text.trim(),
              "email": emailcontroller.text.trim()
            };

            DatabaseReference driverRef =
                FirebaseDatabase.instance.ref().child("users");
            driverRef.child(firebaseUser.uid).set(driverMap);

            currentFirebaseUser = firebaseUser;
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            weekpass();
          } else if (e.code == 'email-already-in-use') {
            weekemail();
          }
          return null;
        } catch (e) {
          print(e);
        }
      }
    }
  }

  bool passwordconfirmed() {
    if (passwodconttroler.text.trim() == conformpasswodconttroler.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void openSignScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwodconttroler.dispose();
    conformpasswodconttroler.dispose();
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
                    top: 58,
                    left: 350,
                  ),
                  child: Form(
                    key: formstate,
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
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 300,
                        bottom: 50,
                        top: 62,
                        right: 20,
                      ),
                      child: Text("Anbobtk",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.03)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        right: 245,
                      ),
                      child: Text(
                        "Hi !",
                        style: TextStyle(
                            fontSize: width * 0.16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 80,
                      ),
                      child: Text(
                        " Welcome",
                        style: TextStyle(
                          fontSize: width * 0.16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 340,
                          left: 35,
                          right: 60,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length > 20) {
                              return "Password is very long";
                            }
                            if (value.length < 7) {
                              return "Password is very short";
                            } else {
                              return null;
                            }
                          },
                          controller: namecontroller,
                          maxLines: 1,
                          cursorColor: colorgray,
                          decoration: InputDecoration(
                            hintText: "Full Name",
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
                          top: 25,
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
                          top: 25,
                          left: 35,
                          right: 60,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length > 30) {
                              return "Password is very long";
                            }
                            if (value.length < 7) {
                              return "Password is very short";
                            } else {
                              return null;
                            }
                          },
                          controller: passwodconttroler,
                          maxLines: 1,
                          cursorColor: colorgray,
                          decoration: InputDecoration(
                            hintText: "Password",
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
                          top: 25,
                          left: 35,
                          right: 60,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length > 20) {
                              return "Password is very long";
                            }
                            if (value.length < 7) {
                              return "Password is very short";
                            } else {
                              return null;
                            }
                          },
                          controller: conformpasswodconttroler,
                          maxLines: 1,
                          cursorColor: colorgray,
                          decoration: InputDecoration(
                            hintText: "Conform password",
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
                      padding: const EdgeInsets.only(right: 25, top: 70),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.77,
                        child: ElevatedButton(
                          onPressed: () {
                            if (signUp() == null) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => googleMapPage()));
                            }
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
                            "Sign Up",
                            textAlign: TextAlign.end,
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
                        padding: const EdgeInsets.only(top: 97.5, left: 100),
                        child: Text("Already have an account?",
                            style: TextStyle(color: colorgray as Color)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 93,
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: Text("Sign In",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.035))),
                      )
                    ]),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
