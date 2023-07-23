import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:useer_app/homeRealPage.dart';

class AmbobaDetals extends StatefulWidget {
  final double width;
  void Function()? onPressed;
  AmbobaDetals({super.key, required this.width, required this.onPressed});

  @override
  State<AmbobaDetals> createState() => _AmbobaDetalsState();
}

class _AmbobaDetalsState extends State<AmbobaDetals> {
  Query dreamA = FirebaseDatabase.instance.ref().child('Products');
  bool pressAttention = false;
  bool preesed = false;
  int conter = 2;

  Widget listingOrder({required Map smap}) => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.12,
            ),
            child: Text(
              smap['name'],
              style: TextStyle(color: Colors.black, fontSize: widget.width),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.010,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                "1 meter gas cylinder hose good quilty and two metel bellet.",
                maxLines: 4,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.14,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.043,
              width: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Background color
                  ),
                  onPressed: widget.onPressed,
                  child: Text(
                    "Price: ${smap['price']}",
                  )),
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
