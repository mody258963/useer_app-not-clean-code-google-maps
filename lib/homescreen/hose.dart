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
            height: MediaQuery.of(context).size.height * 0.020,
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
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text('Price: ${smap['price']}', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045 ),)
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
