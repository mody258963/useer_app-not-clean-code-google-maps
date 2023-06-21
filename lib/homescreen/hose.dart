import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HoseDetals extends StatefulWidget {
  final double width;
  HoseDetals({
    super.key,
    required this.width,
  });

  @override
  State<HoseDetals> createState() => _HoseDetalsState();
}

class _HoseDetalsState extends State<HoseDetals> {
  Query dreamA = FirebaseDatabase.instance.ref().child('Products1');
  bool pressAttention = false;
  bool preesed = false;
  Color GrayOfProduct = Color.fromARGB(153, 240, 227, 227);
  int conter = 2;
  Widget listingOrder({required Map smap}) => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 46,
            ),
            child: Text(
              smap['name'],
              style: TextStyle(color: Colors.black, fontSize: widget.width),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.028,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                "1 meter gas cylinder hose good quilty and two metel bellet ",
                maxLines: 4,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text("More Detals",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {},
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                IconButton(
                    onPressed: () {
                      showFlexibleBottomSheet(
                        minHeight: 0,
                        initHeight: 0.93,
                        maxHeight: 0.93,
                        context: context,
                        builder:
                            (context, scrollController, bottomSheetOffset) {
                          double height = MediaQuery.of(context).size.height;
                          double width = MediaQuery.of(context).size.width;
                          return Container(
                            height: MediaQuery.of(context).size.height * 10,
                            width: MediaQuery.of(context).size.width * 10,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: height * 0.40,
                                  width: width * 0.45,
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0, right: 0, left: 0, top: 8),
                                    child: Image.asset(
                                      'assets/hose.png',
                                      height: height * 0.40,
                                      width: width * 0.42,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      smap['name'],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                    ),
                                    Text("EGP ${smap['price']}")
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        isExpand: false,
                      );

                      Widget _buildBottomSheet(
                        BuildContext context,
                        ScrollController scrollController,
                        double bottomSheetOffset,
                      ) {
                        return Material(
                          child: Container(
                            child: ListView(
                              controller: scrollController,
                              shrinkWrap: true,
                            ),
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.arrow_circle_right_outlined))
              ],
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FirebaseAnimatedList(
          query: dreamA,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map smap = snapshot.value as Map;
            smap['key'] = snapshot.key;
            return listingOrder(smap: smap);
          },
        ));
  }
}
