import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:useer_app/datapage.dart';
import 'package:useer_app/googleMapPage.dart';
import 'package:useer_app/homeRealPage.dart';

import 'app settings/textfildsittings.dart';
import 'login page/global.dart';

class DetalsPage extends StatefulWidget {
  DetalsPage({
    super.key,
  });

  @override
  State<DetalsPage> createState() => _DetalsPageState();
}

GlobalKey<FormState> formstate = GlobalKey<FormState>();

final Fullname = TextEditingController();
final FloorNum = TextEditingController();
final Streetno = TextEditingController();
final Apartment = TextEditingController();
final buildingNumber = TextEditingController();
final phoneNumber = TextEditingController();

class _DetalsPageState extends State<DetalsPage> {
  Color? colorgray = const Color.fromARGB(255, 189, 189, 189);

  Future orderPage() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("orders");

    await ref.child(fAuth.currentUser!.uid).set(myDataModel.toJson());
  }



  Future locaitonOnMap() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child("orders")
        .child(fAuth.currentUser!.uid);

    await ref.child("products").set(myDataModel1.toJson());
  }

  Future Genraldetals() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child("orders")
        .child(fAuth.currentUser!.uid);

    await ref.child("detals").set(myDataModel12.toJson());
  }
  
   Future adressBackup() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child("saved adress")
        .child(fAuth.currentUser!.uid);

    await ref.child("detals").set(myDataModel12.toJson());
  
  }

 Future locaitonOnMapsavedadress() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child("saved adress")
        .child(fAuth.currentUser!.uid);

    await ref.child("locationOnmap").set(myDataModel1.toJson());
  }
  double right = 0.08;
  double left = 0.08;
  double top = 0.01;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add your delivery address",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formstate,
        child: ListView(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: hight * 0.83, minHeight: hight * 0.30),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: hight * 0.05,
                          left: width * left,
                          right: width * right),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length > 40) {
                            return "Name is very long";
                          }
                          if (value.length < 5) {
                            return "Name is very short";
                          } else {
                            return null;
                          }
                        },
                        controller: Fullname,
                        maxLines: 1,
                        cursorColor: colorgray,
                        decoration: InputDecoration(
                          hintText: "Full name",
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2.3, color: colorgray as Color),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorgray as Color, width: 3.8),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: width * left, right: width * right),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length > 30) {
                            return "Street No. Is Very Long";
                          }
                          if (value.length < 4) {
                            return "Street No. Is Very Short";
                          } else {
                            return null;
                          }
                        },
                        controller: Streetno,
                        maxLines: 1,
                        cursorColor: colorgray,
                        decoration: InputDecoration(
                          hintText: "Street no./name",
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2.3, color: colorgray as Color),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorgray as Color, width: 3.8),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: width * left, right: width * right),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length > 18) {
                            return "Building No. Is Very Long";
                          }
                          if (value.length < 1) {
                            return "Building No. Is Very Short";
                          } else {
                            return null;
                          }
                        },
                        controller: buildingNumber,
                        maxLines: 1,
                        cursorColor: colorgray,
                        decoration: InputDecoration(
                          hintText: "Building no.",
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2.3, color: colorgray as Color),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorgray as Color, width: 3.8),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: width * left, right: width * right),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length > 15) {
                            return "No Detals needed";
                          }
                          if (value.length < 1) {
                            return "Please Enter Floor No.";
                          } else {
                            return null;
                          }
                        },
                        controller: FloorNum,
                        maxLines: 1,
                        cursorColor: colorgray,
                        decoration: InputDecoration(
                          hintText: "Floor no.",
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2.3, color: colorgray as Color),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorgray as Color, width: 3.8),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: width * left, right: width * right),
                      child: TextFormField(
                        controller: Apartment,
                        maxLines: 1,
                        cursorColor: colorgray,
                        decoration: InputDecoration(
                          hintText: "Apartment no. (optional)",
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2.3, color: colorgray as Color),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorgray as Color, width: 3.8),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: width * left, right: width * right),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.length > 11) {
                            return "Phone Number is very long (Egyption numbers only)";
                          }
                          if (value.length < 10) {
                            return "11 charactors only";
                          } else {
                            return null;
                          }
                        },
                        controller: phoneNumber,
                        maxLines: 1,
                        cursorColor: colorgray,
                        decoration: InputDecoration(
                          hintText: "Phone no.",
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2.3, color: colorgray as Color),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorgray as Color, width: 3.8),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: hight * 0.15,
                  ),
                  Container(
                    height: hight * 0.06,
                    width: width * 0.85,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Background color
                        ),
                        onPressed: () {
                          var formdata = formstate.currentState;
                          if (formdata!.validate()) {
                            orderPage();
                            locaitonOnMap();
                            Genraldetals();
                            locaitonOnMapsavedadress();
                            adressBackup();
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.04),
                        )),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataModel12 {
  Map<String, dynamic> toJson() {
    return {
      "name": Fullname.text,
      "apartment": Apartment.text,
      "street": Streetno.text,
      "floor": FloorNum.text,
      "building": buildingNumber.text,
      "phone no": phoneNumber.text,
    };
  }
}

MyDataModel12 myDataModel12 = MyDataModel12();
