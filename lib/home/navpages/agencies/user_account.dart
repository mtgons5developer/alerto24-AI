import 'dart:async';
import 'package:alerto24/home/utils/showSnackBar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:location/location.dart' as loc;
import '../../utils/action_button.dart';
import '../../utils/expandable_fab.dart';
import 'package:alerto24/globals.dart' as globals;


class USERHomePAGEWidget extends StatefulWidget {
  const USERHomePAGEWidget({Key? key}) : super(key: key);

  @override
  _USERHomePAGEWidgetState createState() => _USERHomePAGEWidgetState();
}

class _USERHomePAGEWidgetState extends State<USERHomePAGEWidget> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int numOfDispatchTotal = 0;
  int numOfAcceptedTotal = 0;
  int numOfCompletedTotal = 0;
  int status = 0;
  double userLongitude = 0;
  double userLatitude = 0;
  double dispatchLatitude = 0;
  double dispatchLongitude = 0;
  String agencyTypes = '0';

  loc.LocationData? currentLocation;
  loc.Location location =
      loc.Location(); //explicit reference to the Location class for checkGPS

  @override
  void initState() {
    super.initState();
    checkGps();
    listenToDispatch();
    if (globals.book > 0) createTask();
  }

  @override
  void dispose() {
    // listenToDispatch();
    // checkGps();
    // _showDialog();
    super.dispose();
  }

  Future checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  void listenToDispatch() {
    agencyTypes = globals.agencyType.toString();
    for (int i = 1; i < 5; i++) {
      DocumentReference reference = FirebaseFirestore.instance
          .collection(i.toString())
          .doc("los_banos")
          .collection('tasks')
          .doc(globals.uuid);
      reference.snapshots().listen((querySnapshot) {
        numOfDispatchTotal = querySnapshot['numOfDispatch'];
        numOfAcceptedTotal = querySnapshot['numOfAccepted'];
        numOfCompletedTotal = querySnapshot['numOfCompleted'];
        setState(() {
          if (i.toString() == '1') {
            globals.counter1 = numOfDispatchTotal;
            globals.counter1A = numOfAcceptedTotal;
            globals.counter1C = numOfCompletedTotal;
          }

          if (i.toString() == '2') {
            globals.counter2 = numOfDispatchTotal;
            globals.counter2A = numOfAcceptedTotal;
            globals.counter2C = numOfCompletedTotal;
          }

          if (i.toString() == '3') {
            globals.counter3 = numOfDispatchTotal;
            globals.counter3A = numOfAcceptedTotal;
            globals.counter3C = numOfCompletedTotal;
          }

          if (i.toString() == '4') {
            globals.counter4 = numOfDispatchTotal;
            globals.counter4A = numOfAcceptedTotal;
            globals.counter4C = numOfCompletedTotal;
          }
        });
      });
    }
    globals.agencyEntry = 1;
  }

  void _showDialog() {
    Navigator.of(context).pushNamed('/camera_page');

    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       Future.delayed(const Duration(seconds: 5), () {
    //         createTask();
    //         WidgetsBinding.instance.addPostFrameCallback((_) {
    //           Navigator.pushReplacement(context,
    //               MaterialPageRoute(builder: (_) => const CameraApp()));
    //         });
    //       });

    //       return AlertDialog(
    //         title: const Text(
    //             'You are about to send an Alert, you have 5 seconds to cancel or ignore this message and Alert will continue.'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text("Cancel"),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     });
  }

//===========================================================================
  void createTask() {
    agencyTypes = globals.agencyType.toString();
    location.getLocation().then((location) {
      currentLocation = location;
      if (currentLocation != null) {
        var parts = currentLocation.toString().split(",");
        var parts2 = parts[1].replaceAll('long: ', '');
        var userLatitude =
            double.parse(parts[0].replaceAll('LocationData<lat:', ''));
        var userLongitude = double.parse(parts2.replaceAll('>', ''));

        DateTime _now = DateTime.now();
        CollectionReference agency =
            FirebaseFirestore.instance.collection(agencyTypes);

        if (agencyTypes == '1') {
          showSnackBar(context,
              "An Alert has been sent to your locally registered Ambulance. Please wait for them to accept.");
        }
        if (agencyTypes == '2') {
          showSnackBar(context,
              "An Alert has been sent to your locally registered Police. Please wait for them to accept.");
        }
        if (agencyTypes == '3') {
          showSnackBar(context,
              "An Alert has been sent to your locally registered Fire Truck. Please wait for them to accept.");
        }
        if (agencyTypes == '4') {
          showSnackBar(context,
              "An Alert has been sent to your locally registered Barangay. Please wait for them to accept.");
        }
        agency
            .doc('los_banos')
            .collection('tasks')
            .doc(globals.uuid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            numOfDispatchTotal = documentSnapshot['numOfDispatch'] + 1;
            agency
                .doc('los_banos')
                .collection('tasks')
                .doc(globals.uuid)
                .update({
              "status": 1,
              "numOfDispatch": numOfDispatchTotal,
              // "numOfCompleted": 0,
              // "numOfAccepted": 0,
              // "dispatchUUID": '1',
              "dispatchLocation": GeoPoint(dispatchLatitude, dispatchLongitude),
              "userLocation": GeoPoint(userLatitude, userLongitude),
              'updatedTime': _now
            });
            //Update Los_Banos field in tasks collection.
            agency.doc('los_banos').update({
              "numOfDispatch": numOfDispatchTotal,
              // "numOfCompleted": 0,
              // "numOfAccepted": 0,
              'updatedTime': _now
            });
            globals.userLat = userLatitude;
            globals.userLong = userLongitude;
          } else {
            agency.doc('los_banos').collection('tasks').doc(globals.uuid).set({
              "status": 1,
              "numOfDispatch": 1,
              "numOfReject": 0,
              "numOfCompleted": 0,
              "numOfAccepted": 0,
              "dispatchUUID": '',
              "dispatchLocation": GeoPoint(dispatchLatitude, dispatchLongitude),
              "userLocation": GeoPoint(userLatitude, userLongitude),
              'updatedTime': _now
            });
          }
        });
      }
    });
    globals.userLat = userLatitude;
    globals.userLong = userLongitude;
    FlutterRingtonePlayer.playNotification();
    globals.book = 0;
  }

  @override
  void didChangeDependencies() {
    // Provider.of<>(context)
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      // key: _scaffoldKey,
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
                            showBadge: globals.counter3 == 0 ? false : true,
                            position: BadgePosition.topEnd(top: 0, end: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeContent: Text(globals.counter3.toString(),
                                style: const TextStyle(color: Colors.white)),
                            child: Badge(
                                showBadge:
                                    globals.counter3A == 0 ? false : true,
                                position:
                                    BadgePosition.topStart(top: 0, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.yellow,
                                badgeContent: Text(globals.counter3A.toString(),
                                    style:
                                        const TextStyle(color: Colors.black)),
                                child: Badge(
                                    showBadge:
                                        globals.counter3C == 0 ? false : true,
                                    position: BadgePosition.bottomStart(
                                        bottom: 0, start: 0),
                                    padding: const EdgeInsets.all(10.0),
                                    badgeColor: Colors.green,
                                    badgeContent: Text(
                                        globals.counter3C.toString(),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    child: GestureDetector(
                                      onTap: () {
                                        globals.agencyType = 3;
                                        // createTask();
                                        Future(_showDialog);
                                        // Navigator.of(context).pushNamed(
                                        //     '/recording_page',
                                        //     arguments: globals.agencyType);
                                        // setState(() {
                                        //   globals.counter3;
                                        // });
                                      },
                                      onLongPress: () {
                                        globals.agencyType = 3;
                                        resetBookings();
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
                        showBadge: globals.counter4 == 0 ? false : true,
                        position: BadgePosition.topEnd(top: 0, end: 0),
                        padding: const EdgeInsets.all(10.0),
                        badgeContent: Text(globals.counter4.toString(),
                            style: const TextStyle(color: Colors.white)),
                        child: Badge(
                            showBadge: globals.counter4A == 0 ? false : true,
                            position: BadgePosition.topStart(top: 0, start: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeColor: Colors.yellow,
                            badgeContent: Text(globals.counter4A.toString(),
                                style: const TextStyle(color: Colors.black)),
                            child: Badge(
                                showBadge:
                                    globals.counter4C == 0 ? false : true,
                                position: BadgePosition.bottomStart(
                                    bottom: 130, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.green,
                                badgeContent: Text(globals.counter4C.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                child: GestureDetector(
                                  onTap: () {
                                    globals.agencyType = 4;
                                    // createTask();
                                    Future(_showDialog);
                                    // Navigator.of(context).pushNamed(
                                    //     '/recording_page',
                                    //     arguments: globals.agencyType);
                                    // setState(() {
                                    //   globals.counter4;
                                    // });
                                  },
                                  onLongPress: () {
                                    globals.agencyType = 4;
                                    resetBookings();
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
                            showBadge: globals.counter1 == 0 ? false : true,
                            position: BadgePosition.topEnd(top: 0, end: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeContent: Text(globals.counter1.toString(),
                                style: const TextStyle(color: Colors.white)),
                            child: Badge(
                                showBadge:
                                    globals.counter1A == 0 ? false : true,
                                position:
                                    BadgePosition.topStart(top: 0, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.yellow,
                                badgeContent: Text(globals.counter1A.toString(),
                                    style:
                                        const TextStyle(color: Colors.black)),
                                child: Badge(
                                    showBadge:
                                        globals.counter1C == 0 ? false : true,
                                    position: BadgePosition.bottomStart(
                                        bottom: 0, start: 0),
                                    padding: const EdgeInsets.all(10.0),
                                    badgeColor: Colors.green,
                                    badgeContent: Text(
                                        globals.counter1C.toString(),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    child: GestureDetector(
                                      onTap: () {
                                        globals.agencyType = 1;
                                        // createTask();
                                        Future(_showDialog);
                                        // Navigator.of(context).pushNamed(
                                        //     '/recording_page',
                                        //     arguments: globals.agencyType);
                                        // setState(() {
                                        //   globals.counter1;
                                        // });
                                      },
                                      onLongPress: () {
                                        globals.agencyType = 1;
                                        resetBookings();
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
                        showBadge: globals.counter2 == 0 ? false : true,
                        position: BadgePosition.topEnd(top: 0, end: 0),
                        padding: const EdgeInsets.all(10.0),
                        badgeContent: Text(globals.counter2.toString(),
                            style: const TextStyle(color: Colors.white)),
                        child: Badge(
                            showBadge: globals.counter2A == 0 ? false : true,
                            position: BadgePosition.topStart(top: 0, start: 0),
                            padding: const EdgeInsets.all(10.0),
                            badgeColor: Colors.yellow,
                            badgeContent: Text(globals.counter2A.toString(),
                                style: const TextStyle(color: Colors.black)),
                            child: Badge(
                                showBadge:
                                    globals.counter2C == 0 ? false : true,
                                position: BadgePosition.bottomStart(
                                    bottom: 330, start: 0),
                                padding: const EdgeInsets.all(10.0),
                                badgeColor: Colors.green,
                                badgeContent: Text(globals.counter2C.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                child: GestureDetector(
                                  onTap: () {
                                    globals.agencyType = 2;
                                    // createTask();
                                    Future(_showDialog);
                                    // Navigator.of(context).pushNamed(
                                    //     '/recording_page',
                                    //     arguments: globals.agencyType);
                                    // setState(() {
                                    //   globals.counter2;
                                    // });
                                  },
                                  onLongPress: () {
                                    globals.agencyType = 2;
                                    resetBookings();
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
      floatingActionButton: ExpandableFab(
        distance: 120,
        children: [
          ActionButton(
            icon: const Icon(
              Icons.upload,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {},
          ),
          ActionButton(
            icon: const Icon(
              Icons.task,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {},
          ),
          ActionButton(
            icon: const Icon(
              Icons.gps_fixed,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void resetBookings() {
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    DateTime _now = DateTime.now();
    CollectionReference agency =
        FirebaseFirestore.instance.collection(globals.agencyType.toString());
    agency
        .doc('los_banos')
        .collection('tasks')
        .doc(globals.uuid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists ||
          documentSnapshot['numOfDispatch'] > 0 ||
          documentSnapshot['numOfCompleted'] > 0 ||
          documentSnapshot['numOfAccepted'] > 0) {
        setState(() {
          if (globals.agencyType == 1) {
            globals.counter1 = 0;
            globals.counter1A = 0;
            globals.counter1C = 0;
            showSnackBar(context, "Ambulance Alert(s) has been reset.");
          }
          if (globals.agencyType == 2) {
            globals.counter2 = 0;
            globals.counter2A = 0;
            globals.counter2C = 0;
            showSnackBar(context, "Police Alert(s) has been reset.");
          }
          if (globals.agencyType == 3) {
            globals.counter3 = 0;
            globals.counter3A = 0;
            globals.counter3C = 0;
            showSnackBar(context, "Fire Truck Alert(s) has been reset.");
          }
          if (globals.agencyType == 4) {
            globals.counter4 = 0;
            globals.counter4A = 0;
            globals.counter4C = 0;
            showSnackBar(context, "Barangay Alert(s) has been reset.");
          }
        });
        numOfDispatchTotal = 0;
        agency.doc('los_banos').collection('tasks').doc(globals.uuid).update({
          "status": 0,
          "numOfDispatch": 0,
          "numOfCompleted": 0,
          "numOfAccepted": 0,
          'updatedTime': _now
        });
      } else {
        showSnackBar(context, "There's no current Alert(s) on your list.");
      }
    });
    //   }
    //   // updateTasks();
    // } on SocketException catch (_) {
    //   showSnackBar(context, "Internet connection failed.");
    // } on Exception catch (_, e) {
    //   showSnackBar(context, "Internet connection failed. $e");
    // }
  }
}
