import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HoseDetals extends StatefulWidget {
  final double width;
  void Function()? onPressed;
  HoseDetals({
    super.key,
    required this.width,
    required this.onPressed,
  });

  @override
  State<HoseDetals> createState() => _HoseDetalsState();
}

class _HoseDetalsState extends State<HoseDetals> {
  Query dreamA = FirebaseDatabase.instance.ref().child('Products1');
  bool pressAttention = false;

  bool preesed = false;
  Color GrayOfProduct = Color.fromARGB(153, 240, 227, 227);

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
                "1 meter gas cylinder hose good quilty.",
                maxLines: 4,
                style: TextStyle(letterSpacing: MediaQuery.of(context).size.height * 0.0001,),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.018,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.17,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.041,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Background color
                  ),
                  onPressed: widget.onPressed,
                  child: Text("Price: ${smap['price']}")),
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
