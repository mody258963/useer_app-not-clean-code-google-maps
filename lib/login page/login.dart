import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:useer_app/login%20page/SIGNUP.dart';
import 'package:useer_app/login%20page/forgotPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwodconttroler = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Color? colorgray = const Color.fromARGB(255, 189, 189, 189);

  bool code = false;

  void weekpass() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const AlertDialog(
            content: Text("Password is Incorect"),
            title: Text("Wronge Password"),
          );
        });
  }

  void weekemail() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const AlertDialog(
        content: Text("Email is not found"),
        title: Text("Make a New Email"),
      ),
    );
  }

  Future signip() async {
showDialog(context: context, builder: (context){
return Center(
        child: LoadingAnimationWidget.dotsTriangle(
         color: Colors.black,         
          size: 50,
        ),
      );



});

    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwodconttroler.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          weekemail();
        } else if (e.code == 'wrong-password') {
          weekpass();
        }
        return null;
      }
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwodconttroler.dispose();
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
                        top: 62,
                      ),
                      child: Text("Anbobtk",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.03)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        right: 210,
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
                        right: 50,
                      ),
                      child: Text(
                        " Welcome",
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
                            top: 350,
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
                            top: 30,
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
                        padding: const EdgeInsets.only(right: 25, top: 150),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.77,
                          child: ElevatedButton(
                            onPressed: () {
                              signip();
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
                              "Sign In",
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
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 80),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForigotPage()));
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.normal,
                                  color: colorgray),
                            )),
                      ),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 120),
                          child: Text("Create Account ?",
                              style: TextStyle(
                                  color: colorgray as Color,
                                  fontSize: width * 0.035)),
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
                                            const SignUpPage()));
                              },
                              child: Text("Sign Up",
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
