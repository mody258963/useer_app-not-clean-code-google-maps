import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      //get a float button to click and go to current location
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gotoUserCurrentPosition();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(children: [_getMap(), _getCustomPin(), _showDraggedAddress()]);
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
}
