import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:lottie/lottie.dart';
import 'package:place_picker/place_picker.dart';
import 'package:useer_app/homesnap.dart';
import 'package:useer_app/order.dart';

import 'login page/global.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //get map controller to access map
  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";
  TextEditingController searchbarcontroller = TextEditingController();
  String? lat;
  String? long;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    //set default latlng for camera position
    _defaultLatLng = LatLng(11, 104);
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

  Future sendinglocation() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("trender");

    await ref.child(fAuth.currentUser!.uid).set({
      "name": fAuth.currentUser?.uid,
      "age": 'https://www.google.com/maps/search/$lat,$long',
      "adress": _draggedAddress,
    });
  }

  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      _getCustomPin(),
      _showDraggedAddress(),
      _searchBar(),
      _button()
    ]);
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                _liveLocation();
              },
              child: Text("efdfdf"))
        ],
      ),
    );
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
            child: Text(
          _draggedAddress,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.only(top: 100, left: 30, right: 30),
      child: GooglePlacesAutoCompleteTextFormField(
          textEditingController: searchbarcontroller,
          googleAPIKey: "AIzaSyBp0dsQNuxb6tRzI_6mTo9ErJ4smqdanp8",
          inputDecoration: InputDecoration(hintText: "Search your location"),
          debounceTime: 800,
          isLatLngRequired: true,
          countries: ["EG"],
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails" + prediction.lng.toString());
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
      child: Container(
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
  Future _gotoUserCurrentPosition() async {
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

  Future _determineUserCurrentPosition() async {
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
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            title: Text("home "),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            },
          ),
          ListTile(
            title: Text("orders "),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Orderpage(),
                  ));
            },
          )
        ]),
      ),
      body: _buildBody(),
      //get a float button to click and go to current location
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_gotoUserCurrentPosition();
          sendinglocation();
          //_liveLocation();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
