import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:useer_app/home.dart';

import '../app settings/text sittings.dart';

import 'SIGNUP.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwodconttroler = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Future signip() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwodconttroler.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              title: 'User Not Found',
              body: const Text(
                "create a new account",
              )).show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.bottomSlide,
              title: 'Wrong Password',
              body: const Text(
                "Wrong Password for this user",
              )).show();
          return null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: formstate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 160,
                    width: 160,
                  ),
                  const Text("Login",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                  const SizedBox(
                    height: 60,
                    width: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length > 30) {
                          return "Email is very long";
                        }
                        if (value.length < 8) {
                          return "Email is very short";
                        } else {
                          return null;
                        }
                      },
                      controller: emailcontroller,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length > 50) {
                          return "Password is very long";
                        }
                        if (value.length < 8) {
                          return "Password is very short";
                        } else {
                          return null;
                        }
                      },
                      controller: passwodconttroler,
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (signip() == null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Home()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.white,
                      maximumSize: const Size(300, 65),
                      minimumSize: const Size(300, 65),
                    ),
                    child: const DummyText(
                      text: "Sign In",
                      size: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DummyText(text: "Or", size: 6),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 20,
                      top: 10,
                    ),
                    child: Icon(Icons.arrow_downward_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Center(
                heightFactor: 14,
                widthFactor: 14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 42),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                          },
                          child: const DummyText(
                            text: "Sign Up",
                            size: 6,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
