import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locator;
// import 'package:flutter/services.dart' show rootBundle;

class OrderTrackingPage2 extends StatefulWidget {
  const OrderTrackingPage2({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage2> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage2> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(14.1674332, 121.2433546);
  static const LatLng destination = LatLng(14.1823022965, 121.23769984);

  List<LatLng> polylineCoordinates = [];
  locator.LocationData? currentLocation;

  var currentLocation2;
  // var mapCreated = '0';
  late double latitude;
  late double longitude;
  var reload = '0';

  // Future<void> getCurrentLocation2() async {
  //   try {
  //     print('getCurrentLocation2 $getCurrentLocation2');
  //     geolocator.Position posi = await geolocator.Geolocator.getCurrentPosition(
  //         desiredAccuracy: geolocator.LocationAccuracy.high);
  //     latitude = posi.latitude;
  //     longitude = posi.longitude;
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  // getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
  //     .then((loc) => setState(() => currentLocation = loc));

  void getCurrentLocation() async {
    locator.Location location = locator.Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
        if (currentLocation != null) {
          print('getCurrentLocation $currentLocation');
          // exit(0);
        }
      },
    );

    GoogleMapController googleMapController = await _controller.future;
    // print('===============$reload=============');
    // if (reload == '0') {
    // if (currentLocation2 != currentLocation && reload == '0') {
    location.onLocationChanged.listen(
      (newLoc) {
        try {
          currentLocation = newLoc;
          // print('currentLocation = newLoc;');
          // print('===============$reload=============');
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

          if (!mounted) {
            // print("=========NOT MOUNTED====Exit=====");
            // _disposeController();
            // reload = '1';
            return;
          } else {
            setState(() {});
          }
        } catch (e) {
          print(e);
        }
      },
    );
    // }
    // print('===============$reload=============');
    // setState(() {
    //   currentLocation2 = currentLocation;
    // });
  }

  late LatLng currentLatLng;

  @override
  void initState() {
    super.initState();
    // _setMarkersIcons();
    if (reload == '0') {
      getCurrentLocation();
    }

    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        currentLatLng =
            LatLng(currLocation.latitude, currLocation.longitude);
      });
    });

    print('===============$reload=============');

    if (currentLocation != null) {
      if (reload == '0') {
        getPolyPoints();
      }
      print("getPolyPoints");
      // exit(0);
    } else {
      getCurrentLocation();
      // while (mapCreated == '0'){
      //   sleep(Duration(seconds:1));
      //   getPolyPoints();
      //   print('Waiting for Poly Points');
      // }
      getPolyPoints();
      // print(mapCreated);
    }
  }

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

        if (!mounted) {
          // print("=========NOT MOUNTED=====Entry====");
          return;
        } else {
          setState(() {});
        }
      }
    }
  }

  @override
  // void dispose() {
  Future<void> dispose() async {
    // getPolyPoints();
    _disposeController();
    // print("dispose");
    super.dispose();
  }

  void _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }

  // builder: (context, widget) {
  //   Widget error = const Text('...rendering error...');
  //   if (widget is Scaffold || widget is Navigator) {
  //     error = Scaffold(body: Center(child: error));
  //   }
  //   ErrorWidget.builder = (errorDetails) => error;
  //   if (widget != null) return Widget;
  //   throw ('widget is null');
  // },
  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    // print('onMapCreated');
  }

  @override
  Widget build(BuildContext context) {
    // print('BuildContext $currentLocation == $currentLocation2');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/admob.png',
                fit: BoxFit.contain,
                height: 60,
                width: 60,
                alignment: FractionalOffset.center,
              ),
              // Container(
              //     padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
            ],
          ),
        ),
      ),
      // ignore: unnecessary_null_comparison
      body: currentLatLng == null
          // body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              // zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLatLng.latitude, currentLatLng.longitude),
                // LatLng(currentLatLng!.latitude!, currentLatLng!.longitude!),
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
                  position:
                      LatLng(currentLatLng.latitude, currentLatLng.longitude),
                  // currentLatLng!.latitude!, currentLatLng!.longitude!),
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
              // onMapCreated: onMapCreated,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                // print("==onMapCreated==");
                // mapCreated = '1';
                // exit(0);
              },
            ),
    );
  }
}
