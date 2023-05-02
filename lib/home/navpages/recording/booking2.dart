// import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locator;
import 'package:alerto24/globals.dart' as globals;
import '../../utils/showSnackBar.dart';

class OrderTrackingPage44 extends StatefulWidget {
  const OrderTrackingPage44({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  State<OrderTrackingPage44> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage44> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  locator.LocationData? currentLocation;

  // static const LatLng sourceLocation = LatLng(14.1674332, 121.2433546); //Agency
  // static const LatLng destination = LatLng(14.1823022965, 121.23769984); //User

  // if (agency_user == 1)
  final LatLng sourceLocation =
      LatLng(globals.dispatchLat, globals.dispatchLong); //Agency My Location

  final LatLng destination =
      LatLng(globals.userLat, globals.userLong); //User Bel's Location

  CollectionReference agencies =
      FirebaseFirestore.instance.collection(globals.agencyType.toString());

  LatLng? currentLatLng;
  late double latitude;
  late double longitude;
  var agencyFinal;
  var google_api = "AIzaSyDUAfJqnTPw19SDPcHPpCkqEXmu6vzTllM";

  void getCurrentLocation() async {
    locator.Location location = locator.Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
        if (currentLocation != null) {}
      },
    );

    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 14.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (globals.agencyType.toString() == '1') {
      agencyFinal = 'Ambulance';
    } else if (globals.agencyType.toString() == '2') {
      agencyFinal = 'Police';
    } else if (globals.agencyType.toString() == '3') {
      agencyFinal = 'Fire Truck';
    } else if (globals.agencyType.toString() == '4') {
      agencyFinal = 'Barangay';
    } else {
      showSnackBar(context, 'No Agency Dispatch.');
    }
    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        currentLatLng =
            new LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
    getCurrentLocation();
    getPolyPoints();
  }

  //============================================================================

  Future<void> addAgencyLocation() {
    return agencies
        .doc("los_banos")
        .collection('tasks')
        .doc(globals.uuid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        globals.dispatchLat = documentSnapshot.get('dispatchLocation').latitude;
        globals.dispatchLong =
            documentSnapshot.get('dispatchLocation').longitude;
      }
    });
  }

  Future<void> addUserLocation() {
    return agencies
        .doc("los_banos")
        .collection('tasks')
        .doc(globals.uuid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        globals.userLat = documentSnapshot.get('dispatchLocation').latitude;
        globals.userLong = documentSnapshot.get('dispatchLocation').longitude;
      }
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      if (!mounted) {
      } else {
        result.points.forEach(
          (PointLatLng point) => polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          ),
        );
        setState(() {});
      }
    }
  }

  @override
  // void dispose() {
  Future<void> dispose() async {
    _disposeController();
    // if (_subscription != null) _subscription.cancel();
    super.dispose();
  }

  void _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }

  //https://docs.flutter.dev/cookbook/forms/retrieve-input
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$agencyFinal Destination')),
      body: Column(
        children: [
          Expanded(
            child: currentLatLng == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLatLng!.latitude, currentLatLng!.longitude),
                      zoom: 14.5,
                    ),
                    mapType: MapType.normal,
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        points: polylineCoordinates,
                        color: Colors.red.shade900,
                        width: 6,
                      ),
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        position: LatLng(
                            currentLatLng!.latitude, currentLatLng!.longitude),
                        // currentLatLng!.latitude, currentLatLng!.longitude),
                      ),
                      Marker(
                        markerId: const MarkerId("source"),
                        position: sourceLocation,
                        infoWindow: const InfoWindow(
                          title: 'Marker Title Third ',
                          snippet: 'My Custom Subtitle',
                        ),
                      ),
                      Marker(
                        markerId: const MarkerId("destination"),
                        position: destination,
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      showSnackBar(context, currentLatLng.toString());
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
//https://stackoverflow.com/questions/69821594/lateinitializationerror-field-currentlatlng-has-not-been-initialized-in-flutt


