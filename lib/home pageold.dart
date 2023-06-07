import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:useer_app/login%20page/global.dart';

class HomeOld extends StatefulWidget {
  const HomeOld({Key? key}) : super(key: key);

  @override
  State<HomeOld> createState() => _HomeOldState();
}

class _HomeOldState extends State<HomeOld> {
  Stream<QuerySnapshot>? changer;
  double padding = 10;
  DatabaseReference driverRef = FirebaseDatabase.instance.ref();
  late String lat;
  late String long;

  final Completer<GoogleMapController> _controller = Completer();
// on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );
  GoogleMapController? newGoogleMapController;

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  blackMap() {
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  Future<void> _liveLocation() async {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  Future sendinglocation() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("trender");

    await ref.child(fAuth.currentUser!.uid).set({
      "name": fAuth.currentUser?.uid,
      "age": 'https://www.google.com/maps/search/$lat,$long',
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _openMap(String lat, String long) async {
    String googleurl = 'https://www.google.com/maps/search/$lat,$long';
    await canLaunchUrlString(googleurl)
        ? await launchUrlString(googleurl)
        : throw ' ca++++==== $googleurl';
    print(googleurl);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(117, 53, 52, 52),
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Home",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_circle,
                ),
                color: Colors.black,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
              )
            ],
          ),
          body: Stack(
            children: [
              SafeArea(
                // on below line creating google maps
                child: GoogleMap(
                  // on below line setting camera position
                  initialCameraPosition: _kGoogle,
                  // on below line we are setting markers on the map
                  markers: Set<Marker>.of(_markers),
                  // on below line specifying map type.
                  mapType: MapType.normal,
                  // on below line setting user location enabled.
                  myLocationEnabled: true,
                  // on below line setting compass enabled.
                  compassEnabled: true,
                  // on below line specifying controller on map complete.
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                // ElevatedButton(
                //     onPressed: () {
                //       sendinglocation();
                //       _openMap(lat, long);
                //     },
                //     child: const Text("order a anboba"))
                Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        border: Border.all(color: Colors.white)),
                    child: Stack(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 55,
                              left: 32,
                              right: padding,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    alignment: Alignment.centerLeft),
                                onPressed: () {
                                  showBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    builder: (context) {
                                      return ListView(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(
                                                                20)),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: const Stack(children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextField(),
                                              )
                                            ]),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                    "sdfasdfsafsdsdssdasdasdsadasd",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 90, right: 30, left: 40),
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      )
                    ])),
              ]),
            ],
          ),
          // on pressing floating action button the camera will take to user current location
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     getUserCurrentLocation().then((value) async {
          //       lat = '${value.latitude}';
          //       long = '${value.longitude}';
          //       print('lat = $lat ,long = $long');
          //       print("+++++++++++++++++++++++++++++++++++++++==");

          //       // marker added for current users location
          //       _markers.add(Marker(
          //         markerId: MarkerId("2"),
          //         position: LatLng(value.latitude, value.longitude),
          //         infoWindow: InfoWindow(
          //           title: 'My Current Location',
          //         ),
          //       ));

          //       // specified current users location
          //       CameraPosition cameraPosition = new CameraPosition(
          //         target: LatLng(value.latitude, value.longitude),
          //         zoom: 14,
          //       );

          //       final GoogleMapController controller = await _controller.future;
          //       controller.animateCamera(
          //           CameraUpdate.newCameraPosition(cameraPosition));

          //       _liveLocation();
          //     });
          //   },
          //   child: Icon(Icons.local_activity),
          // ),
        ));
  }
}
