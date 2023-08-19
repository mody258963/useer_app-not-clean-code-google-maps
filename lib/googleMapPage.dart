import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:lottie/lottie.dart';
import 'package:useer_app/homeRealPage.dart';
import 'package:useer_app/loadingScreen.dart';
import 'package:restart_app/restart_app.dart';
import 'detalspage.dart';
import 'login page/global.dart';

class googleMapPage extends StatefulWidget {
  googleMapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<googleMapPage> createState() => _googleMapPageState();
}

final Completer<GoogleMapController> _googleMapController = Completer();
CameraPosition? _cameraPosition;
late LatLng _defaultLatLng;
late LatLng _draggedLatlng;
String _draggedAddress = "";
TextEditingController searchbarcontroller = TextEditingController();
String? lat;
String? long;
bool isLoading = true;

class _googleMapPageState extends State<googleMapPage> {
  //get map controller to access map

  @override
  void initState() {
    _init();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  _init() {
    //set default latlng for camera position
    _defaultLatLng = const LatLng(11, 104);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition =
        CameraPosition(target: _defaultLatLng, zoom: 17.5 // number of map view
            );

    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  Future<void> _liveLocation() async {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      print("=========================================");
      print("$lat");
    });
  }

  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      _getCustomPin(),
      //_showDraggedAddress(),
      //_searchBar(),
      _button()
    ]);
  }

  Widget _button() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Container(
                height: hight * 0.06,
                width: width * 0.90,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Background color
                    ),
                    onPressed: () async {
                      _liveLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetalsPage()));
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.04),
                    )),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
            child: Text(
          _draggedAddress,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
      child: GooglePlacesAutoCompleteTextFormField(
          textEditingController: searchbarcontroller,
          googleAPIKey: "AIzaSyBp0dsQNuxb6tRzI_6mTo9ErJ4smqdanp8",
          inputDecoration:
              const InputDecoration(hintText: "Search your location"),
          debounceTime: 800,
          isLatLngRequired: true,
          countries: const ["EG"],
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails${prediction.lng}");
          },
          itmClick: (Prediction prediction) {
            searchbarcontroller.text = prediction.description!;

            searchbarcontroller.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
          }
          // default 600 ms ,
          ),
    );
  }

  Widget _getMap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition:
          _cameraPosition!, //initialize camera position for map
      mapType: MapType.normal,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on map
        //every time user drag and stop it will display address
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        //this function will trigger when user keep dragging on map
        //every time user drag this will get value of latlng
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when map is fully loaded
        if (!_googleMapController.isCompleted) {
          //set controller to google map when it is fully loaded
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: SizedBox(
        width: 80,
        height: 60,
        child: Lottie.asset("assets/pin.json"),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    try {
      List<Placemark> placemarks = await GeocodingPlatform.instance
          .placemarkFromCoordinates(position.latitude, position.longitude,
              localeIdentifier: "en");
      Placemark address = placemarks[0]; // get only first and closest address
      String addresStr =
          "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
      setState(() {
        _draggedAddress = addresStr;
      });
      return placemarks;
    } catch (e) {}
  }

  //get user's current location and set the map's camera to that location
  _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: isLoading
          ? const LoadingScreen()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: BackButton(
                  onPressed: () {
                    Restart.restartApp();
                    Navigator.of(context).pop();
                  },
                  color: Colors.black,
                ),
              ),
              body: _buildBody(),
              //get a float button to click and go to current location
              floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: hight * 0.069),
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _gotoUserCurrentPosition();
                    //sendinglocation();
                    _liveLocation();
                  },
                  child: const Icon(Icons.gps_fixed_outlined),
                ),
              ),
            ),
    );
  }

  void showMaterialModalBottom(
      {required BuildContext context,
      required SingleChildScrollView Function(dynamic context) builder}) {}
}

class MyDataModel1 {
  Map<String, dynamic> toJson() {
    return {
      "uid": fAuth.currentUser?.uid,
      "location link": 'https://www.google.com/maps/search/$lat,$long',
      "adress": _draggedAddress,
    };
  }
}

MyDataModel1 myDataModel1 = MyDataModel1();
