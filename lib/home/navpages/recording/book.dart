// import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locator;
import 'package:alerto24/globals.dart' as globals;
import '../../utils/showSnackBar.dart';

class OrderTrackingPage33 extends StatefulWidget {
  const OrderTrackingPage33({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  State<OrderTrackingPage33> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage33> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  locator.LocationData? currentLocation;
  // if (agency_user == 1)
  static const LatLng sourceLocation = LatLng(14.1674332, 121.2433546); //Agency
  static const LatLng destination = LatLng(14.1823022965, 121.23769984); //User
  late LatLng? currentLatLng;
  late double latitude;
  late double longitude;

  void getCurrentLocation() async {
    locator.Location location = locator.Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
        if (currentLocation != null) {
          // print('getCurrentLocation $currentLocation');
        }
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

  var v1;
  var agencyFinal;

  void getLatitude() {
    CollectionReference agency =
        FirebaseFirestore.instance.collection(widget.data.toString());
    agency
        .doc('los_banos')
        .collection('tasks')
        .doc(globals.uuid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var dispatchLatitude =
            documentSnapshot.get('dispatchLocation').latitude;
      }
    });
  }

  void getLongtitude() {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference agency =
        FirebaseFirestore.instance.collection(widget.data.toString());
    agency
        .doc('los_banos')
        .collection('tasks')
        .doc(currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.get('dispatchLocation').longtitude;
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    var agencyType = widget.data.toString();
    if (agencyType == '1') {
      agencyType = 'Ambulance';
    } else if (agencyType == '2') {
      agencyType = 'Police';
    } else if (agencyType == '3') {
      agencyType = 'Fire Truck';
    } else if (agencyType == '4') {
      agencyType = 'Barangay';
    } else {
      showSnackBar(context, 'No Agency Dispatch.');
    }
    agencyFinal = agencyType;
    // getCurrentLocation();
    // addAgencyLocation();
    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        currentLatLng =
            new LatLng(currLocation.latitude, currLocation.longitude);
        v1 = LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
    getPolyPoints();
  }
  //============================================================================

  var google_api = "AIzaSyDUAfJqnTPw19SDPcHPpCkqEXmu6vzTllM";

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      if (!mounted) {
        // print("result.points.isNotEmpty");
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
    //if (_subscription != null) _subscription.cancel();
    super.dispose();
  }

  CollectionReference agencies = FirebaseFirestore.instance.collection('1');

  Future<void> addAgencyLocation() {
    return agencies
        .doc("los_banos")
        .collection('tasks')
        .doc(globals.uuid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final LatLng currentLatLng = LatLng(
            documentSnapshot.get('dispatchLocation').latitude,
            documentSnapshot.get('dispatchLocation').longitude);
        // late LatLng currentLatLng = const LatLng(14.1674332, 121.2433546);
        // print(documentSnapshot.get('dispatchLocation').latitude);
        // print(documentSnapshot.get('dispatchLocation').longitude);
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
        final LatLng sourceLocation = LatLng(
            documentSnapshot.get('userLocation').latitude,
            documentSnapshot.get('userLocation').longitude);
        print(sourceLocation);
        // late LatLng currentLatLng = const LatLng(14.1674332, 121.2433546);
        // print(documentSnapshot.get('dispatchLocation').latitude);
        // print(documentSnapshot.get('dispatchLocation').longitude);
      }
    });
  }

  void _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }

  //https://docs.flutter.dev/cookbook/forms/retrieve-input
  @override
  Widget build(BuildContext context) {
    // CollectionReference agency = FirebaseFirestore.instance.collection('1');
    // agency
    //     .doc('los_banos')
    //     .collection('tasks')
    //     .doc(globals.uuid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     late LatLng sourceLocation = LatLng(
    //         documentSnapshot.get('userLocation').latitude,
    //         documentSnapshot.get('userLocation').longitude);
    //   }
    // });
    return Scaffold(
      appBar: AppBar(title: Text('$agencyFinal Dispatch Location')),
      body: Column(
        children: [
          Expanded(
            child: currentLatLng == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLatLng!.latitude!, currentLatLng!.longitude!),
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
                        position: LatLng(currentLatLng!.latitude!,
                            currentLatLng!.longitude!),
                      ),
                      const Marker(
                        markerId: MarkerId("source"),
                        position: sourceLocation,
                        infoWindow: InfoWindow(
                          title: 'Marker Title Third ',
                          snippet: 'My Custom Subtitle',
                        ),
                      ),
                      const Marker(
                        markerId: MarkerId("destination"),
                        position: destination,
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      // showSnackBar(context, sourceLocation.toString());
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
//https://stackoverflow.com/questions/69821594/lateinitializationerror-field-currentlatlng-has-not-been-initialized-in-flutt

class GetLatitude {
  double dispatchLatitude;
  double dispatchLongitude;

  GetLatitude(
      {required this.dispatchLatitude, required this.dispatchLongitude});
}
