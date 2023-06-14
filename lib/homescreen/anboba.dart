import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool pressAttention = false;
  bool preesed = false;
  int conter = 2;
  Widget listingOrder({required Map smap}) => Column(
        children: [
          Text(
            smap['name'],
            style: TextStyle(color: Colors.black, fontSize: widget.width),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70, left: 45),
            child: Row(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: ElevatedButton(
                      child: Text("New \n ${smap['unfild price']} EGP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  pressAttention ? Colors.white : Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.0251)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (pressAttention == true) {
                              return Colors.black;
                            } else {
                              return Colors.white;
                            }
                          },
                        ),
                      ),
                      onPressed: () {
                        if (conter == 2) {
                          setState(() {
                            pressAttention = !pressAttention;
                          });
                        }
                        conter = 1;
                      },
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: ElevatedButton(
                      child: Text("Refill \n ${smap['price']} EGP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  pressAttention ? Colors.black : Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.0251)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (pressAttention == true) {
                              return Colors.white;
                            } else {
                              return Colors.black;
                            }
                          },
                        ),
                      ),
                      onPressed: () {
                        if (conter == 1) {
                          setState(() {
                            pressAttention = !pressAttention;
                          });
                        }
                        conter = 2;
                      },
                    )),
              ],
            ),
          ),
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
