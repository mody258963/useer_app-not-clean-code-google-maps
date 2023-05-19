import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:useer_app/order.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference starCountRef =
      FirebaseDatabase.instance.ref().child('trender');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('users');
  Query dreamA = FirebaseDatabase.instance.ref().child('trender');

  Widget listingOrder({required Map smap}) => Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.yellow,
          boxShadow: [BoxShadow(color: Colors.white)],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(smap['name']),
          Text(smap['adress']),
          ElevatedButton(
              onPressed: () {
                reference.child(smap['key']).set(smap);
                starCountRef.child(smap['key']).remove();
              },
              child: Text("ddffdf"))
        ]),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dreamA,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map smap = snapshot.value as Map;
              smap['key'] = snapshot.key;
              return listingOrder(smap: smap);
            },
          ),
        ));
  }
}
