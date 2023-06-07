import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;

class AmbobaDetals extends StatefulWidget {
  final double width;
  AmbobaDetals({
    super.key,
    required this.width,
  });

  @override
  State<AmbobaDetals> createState() => _AmbobaDetalsState();
}

class _AmbobaDetalsState extends State<AmbobaDetals> {
  Query dreamA = FirebaseDatabase.instance.ref().child('Products');

  Widget listingOrder({required Map smap}) => Text(
        smap['name'],
        style: TextStyle(color: Colors.black, fontSize: widget.width),
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
