import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReglatorDetals extends StatefulWidget {
  final double width;
  ReglatorDetals({
    super.key,
    required this.width,
  });

  @override
  State<ReglatorDetals> createState() => _ReglatorDetalsState();
}

class _ReglatorDetalsState extends State<ReglatorDetals> {
  Query dreamA = FirebaseDatabase.instance.ref().child('Products2');
  bool pressAttention = false;
  bool preesed = false;
  Color GrayOfProduct = Color.fromARGB(153, 240, 227, 227);
  int conter = 2;
  Widget listingOrder({required Map smap}) => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.017,
          ),
          Padding(
            padding:  EdgeInsets.only(
              right:  MediaQuery.of(context).size.height * 0.015,
            ),
            child: Text(
              smap['name'],
              style: TextStyle(color: Colors.black, fontSize: widget.width),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                "Gas cylinder regulators made to reduce the pressure of gas in the cylinder ",
                maxLines: 4,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text('Price: ${smap['price']}', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045 ),)
        ]
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