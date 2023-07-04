import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:useer_app/homescreen/anboba.dart';

import 'homescreen/hose.dart';
import 'homescreen/monzem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int conter = 0;
int conter1 = 0;
int conter2 = 0;
class _HomePageState extends State<HomePage> {
  Color GrayOfProduct = Color.fromARGB(153, 240, 227, 227);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(240, 240, 212, 140),
              Color.fromARGB(255, 245, 235, 219),
              Color.fromARGB(255, 255, 255, 252),
              Color.fromARGB(255, 255, 255, 252),
              Colors.white,
              Colors.white,
              Colors.white,
              Color.fromARGB(255, 255, 255, 252),
              Color.fromARGB(255, 255, 255, 252),
              Color.fromARGB(255, 255, 255, 252),
              Color.fromARGB(255, 245, 235, 219),
              Color.fromARGB(240, 240, 212, 140),
            ],
          )),
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
                          onPressed: () async {},
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
                          fontSize: width * 0.073, fontWeight: FontWeight.bold),
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
              SingleChildScrollView(
                
                  child: Padding(
                padding:
                    EdgeInsets.only(left: width * 0.086, top: width * 0.09),
                child: Container(

                  height: height * 0.65,
                  width: width * 0.90,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Stack(children: [
                    Padding(
                        padding: EdgeInsets.only(top: width * 0.01),
                        child: Container(
                          height: height * 0.185,
                          width: width * 0.82,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(153, 240, 227, 227),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.75),
                                    child: CupertinoButton(
                                        minSize: double.minPositive,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            conter++;
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
                                        top: width * 0.045, right: width * 0.70),
                                    child: Text(
                                      "$conter",
                                      style: TextStyle(fontSize: width * 0.065),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: width * 0.75,
                                        top: width * 0.033),
                                    child: CupertinoButton(
                                        minSize: double.minPositive,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            if (conter != 0) {
                                              conter--;
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.indeterminate_check_box_rounded,
                                          size: width * 0.12,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                padding: const EdgeInsets.only(left: 100),
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 0.80,
                                  child: AmbobaDetals(
                                    width: width * 0.05,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Padding(
                        padding:  EdgeInsets.only(top: width * 0.45),
                        child: Container(
                          height: height * 0.185,
                          width: width * 0.82,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(153, 240, 227, 227),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.75),
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
                                        top: width * 0.045, right: width * 0.70),
                                    child: Text(
                                      "$conter1",
                                      style: TextStyle(fontSize: width * 0.065),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: width * 0.75,
                                        top: width * 0.033),
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
                                          Icons.indeterminate_check_box_rounded,
                                          size: width * 0.12,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                padding: EdgeInsets.only(left: width * 0.19),
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 0.80,
                                  child: HoseDetals(
                                    width: width * 0.05,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        Padding(
                        padding:  EdgeInsets.only(top: width *0.90),
                        child: Container(
                          height: height * 0.185,
                          width: width * 0.82,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(153, 240, 227, 227),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.75),
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
                                        top: width * 0.045, right: width * 0.70),
                                    child: Text(
                                      "$conter2",
                                      style: TextStyle(fontSize: width * 0.065),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: width * 0.75,
                                        top: width * 0.033),
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
                                          Icons.indeterminate_check_box_rounded,
                                          size: width * 0.12,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                padding: EdgeInsets.only(left: width * 0.19),
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 0.80,
                                  child: ReglatorDetals(
                                    width: width * 0.05,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        
                  ]),
                ),
              )),
              Padding(
                          padding:  EdgeInsets.only(top: width * 0.0001,),
                          child: Container(width: width * 0.82,
                         
                            child: ElevatedButton(child: Text("Confirm",textAlign: TextAlign.center),style: ElevatedButton.styleFrom(
    primary: Colors.black, // Background color
  ),onPressed: () {
                              
                            },),
                          ),
                        ),
            ],
          ),
        ),
      ),
    ));
  }
}
