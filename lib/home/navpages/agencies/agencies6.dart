import 'dart:async';
import 'package:alerto24/home/utils/showSnackBar.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
import '../../utils/action_button.dart';
import '../../utils/expandable_fab.dart';

class USERHomePAGEWidget34 extends StatefulWidget {
  const USERHomePAGEWidget34({super.key});

  @override
  _USERHomePAGEWidgetState createState() => _USERHomePAGEWidgetState();
}

class _USERHomePAGEWidgetState extends State<USERHomePAGEWidget34> {
  late int _counter1 = 0;
  late int _counter2 = 0;
  late int _counter3 = 0;
  late int _counter4 = 0;
  late int _counter1A = 0;
  late int _counter2A = 0;
  late int _counter3A = 0;
  late int _counter4A = 0;
  late int _counter1C = 0;
  late int _counter2C = 0;
  late int _counter3C = 0;
  late int _counter4C = 0;

  String? uuid = "";
  String dispatchUUID = "";
  int numOfDispatchTotal = 0;
  int passed = 0;
  int covid19 = 0;
  int status = 0;
  int agencyType = 0;
  double userLongitude = 0;
  double userLatitude = 0;
  int agencyTypes = 0;

  loc.Location location =
      loc.Location(); //explicit reference to the Location class for checkGPS

  Future checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  @override
  void initState() {
    super.initState();
    checkGps();
    updateDispatch();
    updateAccepted();
    updateCompleted();
  }

  void updateCompleted() {
    var currentUser = FirebaseAuth.instance.currentUser;

    for (int i = 1; i < 5; i++) {
      CollectionReference agency =
          FirebaseFirestore.instance.collection(i.toString());
      agency
          .doc('los_banos')
          .collection('tasks')
          .doc(currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          numOfDispatchTotal = documentSnapshot['numOfCompleted'];
          setState(() {
            if (i == 1) _counter1C = numOfDispatchTotal;
            if (i == 2) _counter2C = numOfDispatchTotal;
            if (i == 3) _counter3C = numOfDispatchTotal;
            if (i == 4) _counter4C = numOfDispatchTotal;
          });
        } else {
          numOfDispatchTotal = 0;
        }
      });
    }
  }

  void updateAccepted() {
    var currentUser = FirebaseAuth.instance.currentUser;

    for (int i = 1; i < 5; i++) {
      CollectionReference agency =
          FirebaseFirestore.instance.collection(i.toString());
      agency
          .doc('los_banos')
          .collection('tasks')
          .doc(currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          numOfDispatchTotal = documentSnapshot['numOfAccepted'];
          setState(() {
            if (i == 1) _counter1A = numOfDispatchTotal;
            if (i == 2) _counter2A = numOfDispatchTotal;
            if (i == 3) _counter3A = numOfDispatchTotal;
            if (i == 4) _counter4A = numOfDispatchTotal;
          });
        } else {
          numOfDispatchTotal = 0;
        }
      });
    }
  }

  void updateDispatch() {
    var currentUser = FirebaseAuth.instance.currentUser;

    for (int i = 1; i < 5; i++) {
      CollectionReference agency =
          FirebaseFirestore.instance.collection(i.toString());
      agency
          .doc('los_banos')
          .collection('tasks')
          .doc(currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          numOfDispatchTotal = documentSnapshot['numOfDispatch'];
          setState(() {
            if (i == 1) _counter1 = numOfDispatchTotal;
            if (i == 2) _counter2 = numOfDispatchTotal;
            if (i == 3) _counter3 = numOfDispatchTotal;
            if (i == 4) _counter4 = numOfDispatchTotal;
          });
        } else {
          numOfDispatchTotal = 0;
        }
      });
    }
  }

  loc.LocationData? currentLocation;

  void createTask() {
    agencyTypes = agencyType;
    //https://pub.dev/packages/geoflutterfire/example
    //https://firebase.flutter.dev/docs/firestore/usage/

    location.getLocation().then((location) {
      currentLocation = location;
      if (currentLocation != null) {
        var parts = currentLocation.toString().split(",");
        var parts2 = parts[1].replaceAll('long: ', '');
        var userLatitude =
            double.parse(parts[0].replaceAll('LocationData<lat:', ''));
        var userLongitude = double.parse(parts2.replaceAll('>', ''));

        DateTime _now = DateTime.now();
        var currentUser = FirebaseAuth.instance.currentUser;
        CollectionReference agency =
            FirebaseFirestore.instance.collection(agencyTypes.toString());

        if (agencyTypes == 1) {
          numOfDispatchTotal = _counter1;
        }
        if (agencyTypes == 2) {
          numOfDispatchTotal = _counter2;
        }
        if (agencyTypes == 3) {
          numOfDispatchTotal = _counter3;
        }
        if (agencyTypes == 4) {
          numOfDispatchTotal = _counter4;
        }
        agency
            .doc('los_banos')
            .collection('tasks')
            .doc(currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            numOfDispatchTotal = documentSnapshot['numOfDispatch'] + 1;
            agency
                .doc('los_banos')
                .collection('tasks')
                .doc(currentUser.uid)
                .update({
              "status": 1,
              "numOfDispatch": numOfDispatchTotal,
              "numOfCompleted": 0,
              "numOfAccepted": 0,
              "dispatchUUID": dispatchUUID,
              "dispatchLocation": GeoPoint(userLatitude, userLongitude),
              "userLocation": GeoPoint(userLatitude, userLongitude),
              'updatedTime': _now
            });

            agency.doc('los_banos').update({
              "numOfDispatch": numOfDispatchTotal,
              "numOfAccepted": 0,
              "numOfCompleted": 0
            });
          } else {
            agency
                .doc('los_banos')
                .collection('tasks')
                .doc(currentUser.uid)
                .set({
              "status": 1,
              "numOfDispatch": numOfDispatchTotal,
              "numOfCompleted": 0,
              "numOfAccepted": 0,
              "dispatchUUID": "",
              "dispatchLocation": GeoPoint(userLatitude, userLongitude),
              "userLocation": GeoPoint(userLatitude, userLongitude),
              'updatedTime': _now
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double iconheight1;
    double iconheight3;

    if (height > 600) {
      iconheight1 = 450;
      iconheight3 = 250;
    } else {
      iconheight1 = 325;
      iconheight3 = 150;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Column(
              mainAxisSize: MainAxisSize.max,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Image.asset(
                'assets/images/emergency.jpg',
                width: double.infinity,
                // height: 850,
                height: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
//============================Fire Truck============================================
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(45, iconheight1, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                        child: Badge(
                            showBadge: _counter3 == 0 ? false : true,
                            position: BadgePosition.topEnd(top: 0, end: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeContent: Text(_counter3.toString(),
                                style: const TextStyle(color: Colors.white)),
                            child: Badge(
                                showBadge: _counter3A == 0 ? false : true,
                                position:
                                    BadgePosition.topStart(top: 0, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.yellow,
                                badgeContent: Text(_counter3A.toString(),
                                    style:
                                        const TextStyle(color: Colors.black)),
                                child: Badge(
                                    showBadge: _counter3C == 0 ? false : true,
                                    position: BadgePosition.bottomStart(
                                        bottom: 0, start: 0),
                                    padding: const EdgeInsets.all(10.0),
                                    badgeColor: Colors.green,
                                    badgeContent: Text(_counter3C.toString(),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        agencyType = 3;
                                        createTask();
                                        // Navigator.of(context).pushNamed(
                                        //     '/recording_page',
                                        //     arguments: agencyType);
                                        agencyType = 0;
                                        setState(() {
                                          _counter3++;
                                        });
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 10,
                                        shape: const CircleBorder(),
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.asset(
                                                'assets/images/firetruck.png',
                                              ).image,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xFFFF0000),
                                              width: 5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )))),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'FIRE TRUCK',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
//=============================Barangay===========================================
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                    child: Badge(
                        showBadge: _counter4 == 0 ? false : true,
                        position: BadgePosition.topEnd(top: 0, end: 0),
                        padding: const EdgeInsets.all(10.0),
                        badgeContent: Text(_counter4.toString(),
                            style: const TextStyle(color: Colors.white)),
                        child: Badge(
                            showBadge: _counter4A == 0 ? false : true,
                            position: BadgePosition.topStart(top: 0, start: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeColor: Colors.yellow,
                            badgeContent: Text(_counter4A.toString(),
                                style: const TextStyle(color: Colors.black)),
                            child: Badge(
                                showBadge: _counter4C == 0 ? false : true,
                                position: BadgePosition.bottomStart(
                                    bottom: 130, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.green,
                                badgeContent: Text(_counter4C.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    agencyType = 4;
                                    createTask();
                                    // Navigator.of(context).pushNamed(
                                    //     '/recording_page',
                                    //     arguments: agencyType);
                                    agencyType = 0;
                                    setState(() {
                                      _counter4++;
                                      // _counter4A;
                                      // _counter4C;
                                    });
                                  },
                                  onLongPress: () => {
                                    showSnackBar(
                                        context, "Loading Details page."),
                                  },
                                  onTap: () => {
                                    showSnackBar(
                                        context, "Double Tap to send Alert!"),
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 5),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 10,
                                          shape: const CircleBorder(),
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/barangay.png',
                                                  height: 0.1,
                                                  width: 0.1,
                                                ).image,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color(0x33000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: const Color(0xFFFF0000),
                                                width: 5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'BARANGAY',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )))),
                  ),
                ],
              ),
            ),
//============================Ambulance============================================

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(45, iconheight3, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                        child: Badge(
                            showBadge: _counter1 == 0 ? false : true,
                            position: BadgePosition.topEnd(top: 0, end: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeContent: Text(_counter1.toString(),
                                style: const TextStyle(color: Colors.white)),
                            child: Badge(
                                showBadge: _counter1A == 0 ? false : true,
                                position:
                                    BadgePosition.topStart(top: 0, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.yellow,
                                badgeContent: Text(_counter1A.toString(),
                                    style:
                                        const TextStyle(color: Colors.black)),
                                child: Badge(
                                    showBadge: _counter1C == 0 ? false : true,
                                    position: BadgePosition.bottomStart(
                                        bottom: 0, start: 0),
                                    padding: const EdgeInsets.all(10.0),
                                    badgeColor: Colors.green,
                                    badgeContent: Text(_counter1C.toString(),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        agencyType = 1;
                                        createTask();
                                        // Navigator.of(context).pushNamed(
                                        //     '/recording_page',
                                        //     arguments: agencyType);
                                        agencyType = 0;
                                        setState(() {
                                          _counter1++;
                                        });
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 10,
                                        shape: const CircleBorder(),
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            // color: FlutterFlowTheme.of(context)
                                            //     .secondaryBackground,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.asset(
                                                'assets/images/ambulance.png',
                                              ).image,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xFFFF0000),
                                              width: 5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )))),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'AMBULANCE',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
//===============================Police=========================================
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                    child: Badge(
                        showBadge: _counter2 == 0 ? false : true,
                        position: BadgePosition.topEnd(top: 0, end: 0),
                        padding: const EdgeInsets.all(10.0),
                        badgeContent: Text(_counter2.toString(),
                            style: const TextStyle(color: Colors.white)),
                        child: Badge(
                            showBadge: _counter2A == 0 ? false : true,
                            position: BadgePosition.topStart(top: 0, start: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeColor: Colors.yellow,
                            badgeContent: Text(_counter2A.toString(),
                                style: const TextStyle(color: Colors.black)),
                            child: Badge(
                                showBadge: _counter2C == 0 ? false : true,
                                position: BadgePosition.bottomStart(
                                    bottom: 330, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.green,
                                badgeContent: Text(_counter2C.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    agencyType = 2;
                                    createTask();
                                    // Navigator.of(context).pushNamed(
                                    //     '/recording_page',
                                    //     arguments: agencyType);
                                    agencyType = 0;
                                    setState(() {
                                      _counter2++;
                                    });
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 5),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 10,
                                          shape: const CircleBorder(),
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/police.png',
                                                  height: 0.1,
                                                  width: 0.1,
                                                ).image,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color(0x33000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: const Color(0xFFFF0000),
                                                width: 5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'POLICE',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 735, 0, 0),
              child: Material(
                color: Colors.transparent,
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    // color: FlutterFlowTheme.of(context).primaryBtnText,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(distance: 120, children: [
        ActionButton(
          icon: const Icon(
            Icons.upload,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            // print('Send to selected Agency');
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.gps_fixed,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            // print('Send to All');
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.task,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            // print(' COVID19');
          },
        ),
      ]),
    );
  }
}
