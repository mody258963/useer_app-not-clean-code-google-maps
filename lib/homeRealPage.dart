import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:useer_app/homescreen/anboba.dart';
import 'package:useer_app/loadingScreen.dart';
import 'googleMapPage.dart';
import 'homescreen/hose.dart';
import 'homescreen/monzem.dart';
import 'login page/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

int conters = 0;
int conter1 = 0;
int conter2 = 0;
bool isLoading = true;

class _HomePageState extends State<HomePage> {
  Color GrayOfProduct = Color.fromARGB(153, 240, 227, 227);

  Future sendinglocation() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("orders");

    await ref
        .child(fAuth.currentUser!.uid)
        .set({"amboba quntaty": conters, "hose": conter1, "reglator": conter2});
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'ReadexPro',
        ),
        home: isLoading
            ? const LoadingScreen()
            : Scaffold(
                body: Center(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white70),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width * 0.078,
                                  top: width * 0.15,
                                ),
                                child: Text(
                                  "Dashboard",
                                  style: TextStyle(fontSize: width * 0.06),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.46,
                                    top: width * 0.13,
                                    right: width * 0.005),
                                child: CupertinoButton(
                                    minSize: double.minPositive,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                    },
                                    child: Icon(
                                      Icons.account_box_sharp,
                                      size: width * 0.08,
                                      color: Colors.black,
                                    )),
                              ),
                            ]),
                            SizedBox(
                              height: height * 0.075,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.13),
                              child: Text(
                                "Hello, from database!",
                                style: TextStyle(
                                    fontSize: width * 0.073,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.29),
                              child: Text(
                                "We glad to see you back",
                                style: TextStyle(fontSize: width * 0.05),
                              ),
                            )
                          ],
                        ),
                        ListView(shrinkWrap: true, children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.086,
                            ),
                            child: Container(
                              height: height * 0.65,
                              width: width * 0.90,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: Stack(children: [
                                Padding(
                                    padding: EdgeInsets.only(top: width * 0.01),
                                    child: Container(
                                      height: height * 0.185,
                                      width: width * 0.82,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            153, 240, 227, 227),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: width * 0.75),
                                                child: CupertinoButton(
                                                    minSize: double.minPositive,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      setState(() {
                                                        conters++;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add_box_rounded,
                                                      size: width * 0.12,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: width * 0.045,
                                                    right: width * 0.70),
                                                child: Text(
                                                  "$conters",
                                                  style: TextStyle(
                                                      fontSize: width * 0.065),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: width * 0.75,
                                                    top: width * 0.027),
                                                child: CupertinoButton(
                                                    minSize: double.minPositive,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      setState(() {
                                                        if (conters != 0) {
                                                          conters--;
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .indeterminate_check_box_rounded,
                                                      size: width * 0.12,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 0,
                                                    right: width * 0.48,
                                                    left: width * 0.12,
                                                    top: width * 0.01),
                                                child: Image.asset(
                                                  'assets/gas.png',
                                                  height: height * 0.17,
                                                  width: width * 0.19,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100),
                                            child: Container(
                                              height: height * 0.25,
                                              width: width * 0.80,
                                              child: AmbobaDetals(
                                                width: width * 0.05,
                                                onPressed: () {
                                                  setState(() {
                                                    if (conters == 0) {
                                                      conters++;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: width * 0.45),
                                    child: Container(
                                      height: height * 0.185,
                                      width: width * 0.82,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            153, 240, 227, 227),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: width * 0.75),
                                                child: CupertinoButton(
                                                    minSize: double.minPositive,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      setState(() {
                                                        conter1++;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add_box_rounded,
                                                      size: width * 0.12,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: width * 0.045,
                                                    right: width * 0.70),
                                                child: Text(
                                                  "$conter1",
                                                  style: TextStyle(
                                                      fontSize: width * 0.065),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: width * 0.75,
                                                    top: width * 0.027),
                                                child: CupertinoButton(
                                                    minSize: double.minPositive,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      setState(() {
                                                        if (conter1 != 0) {
                                                          conter1--;
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .indeterminate_check_box_rounded,
                                                      size: width * 0.12,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 0,
                                                    right: width * 0.48,
                                                    left: width * 0.13,
                                                    top: width * 0.01),
                                                child: Image.asset(
                                                  'assets/hose.png',
                                                  height: height * 0.17,
                                                  width: width * 0.19,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.19),
                                            child: Container(
                                              height: height * 0.25,
                                              width: width * 0.80,
                                              child: HoseDetals(
                                                width: width * 0.05,
                                                onPressed: () {
                                                  setState(() {
                                                    if (conter1 == 0) {
                                                      conter1++;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: width * 0.89),
                                    child: Container(
                                      height: height * 0.185,
                                      width: width * 0.82,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            153, 240, 227, 227),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: width * 0.75),
                                                child: CupertinoButton(
                                                    minSize: double.minPositive,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      setState(() {
                                                        conter2++;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add_box_rounded,
                                                      size: width * 0.12,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: width * 0.045,
                                                    right: width * 0.70),
                                                child: Text(
                                                  "$conter2",
                                                  style: TextStyle(
                                                      fontSize: width * 0.065),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: width * 0.75,
                                                    top: width * 0.027),
                                                child: CupertinoButton(
                                                    minSize: double.minPositive,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      setState(() {
                                                        if (conter2 != 0) {
                                                          conter2--;
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .indeterminate_check_box_rounded,
                                                      size: width * 0.12,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 0,
                                                    right: width * 0.48,
                                                    left: width * 0.13,
                                                    top: width * 0.01),
                                                child: Image.asset(
                                                  'assets/mezan.png',
                                                  height: height * 0.17,
                                                  width: width * 0.19,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.19),
                                            child: Container(
                                              height: height * 0.25,
                                              width: width * 0.80,
                                              child: reglatodetals(
                                                width: width * 0.05,
                                                onPressed: () {
                                                  setState(() {
                                                    if (conter2 == 0) {
                                                      conter2++;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ]),
                            ),
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.only(
                            top: width * 0.0001,
                          ),
                          child: Container(
                            width: width * 0.82,
                            child: ElevatedButton(
                              child:
                                  Text("Confirm", textAlign: TextAlign.center),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black, // Background color
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => googleMapPage()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}

class MyDataModel {
  Map<String, dynamic> toJson() {
    return {"amboba quntaty": conters, "hose": conter1, "reglator": conter2};
  }
}

MyDataModel myDataModel = MyDataModel();
