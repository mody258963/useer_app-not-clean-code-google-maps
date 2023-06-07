import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:useer_app/snapshot.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int conter = 0;

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
              Color.fromARGB(255, 255, 255, 242),
              Color.fromARGB(255, 255, 255, 242),
              Color.fromARGB(255, 255, 255, 242),
              Color.fromARGB(255, 255, 255, 242),
              Color.fromARGB(255, 245, 235, 219),
              Color.fromARGB(240, 240, 212, 140),
            ],
          )),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 45,
                        top: 60,
                      ),
                      child: Text(
                        "Dashboard",
                        style: TextStyle(fontSize: width * 0.06),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 140, top: 47, right: 8),
                      child: CupertinoButton(
                          minSize: double.minPositive,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Icon(
                            Icons.account_box_sharp,
                            size: width * 0.08,
                            color: Colors.black,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 47),
                      child: CupertinoButton(
                          minSize: double.minPositive,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Icon(
                            Icons.density_medium_sharp,
                            size: width * 0.073,
                            color: Colors.black,
                          )),
                    )
                  ]),
                  SizedBox(
                    height: height * 0.075,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 31),
                    child: Text(
                      "Hello, from database!",
                      style: TextStyle(
                          fontSize: width * 0.073, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 98),
                    child: Text(
                      "We glad to see you back",
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(left: 38, top: 250),
                child: Container(
                  height: height * 0.65,
                  width: width * 0.90,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Stack(children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                                    padding: const EdgeInsets.only(right: 300),
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
                                          size: width * 0.1,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 290),
                                    child: Text(
                                      "$conter",
                                      style: TextStyle(fontSize: width * 0.065),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 300, top: 20.6),
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
                                          size: width * 0.1,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0,
                                        right: 130,
                                        left: 0,
                                        top: 20),
                                    child: Image.asset(
                                      'assets/boba1.png',
                                      height: height * 0.15,
                                      width: width * 0.17,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 150),
                                child: Container(
                                  height: height * 0.2,
                                  width: width * 0.2,
                                  child: AmbobaDetals(
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
            ],
          ),
        ),
      ),
    ));
  }
}
