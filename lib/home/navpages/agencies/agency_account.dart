import 'dart:io';

import 'package:alerto24/home/utils/showSnackBar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:alerto24/globals.dart' as globals;
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:location/location.dart' as loc;
import 'package:video_player/video_player.dart';

class AgencyHomePage extends StatefulWidget {
  const AgencyHomePage({super.key});

  @override
  _AgencyHomePageState createState() => _AgencyHomePageState();
}

class _AgencyHomePageState extends State<AgencyHomePage> {
  int numOfDispatchTotal = 0;
  int numOfAcceptedTotal = 0;
  int numOfCompletedTotal = 0;
  String agencyTypes = '0';

  @override
  void initState() {
    super.initState;
    checkGps();
    // getUserType();
    if (globals.agencyEntry == 0) updateDispatch();
    // updateDispatch();
  }

  loc.LocationData? currentLocation;
  loc.Location location =
      loc.Location(); //explicit reference to the Location class for checkGPS

  Future checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateDispatch() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DateTime _now = DateTime.now();

    users.doc(globals.uuid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists || documentSnapshot['agency'] > 1) {
        globals.userType = documentSnapshot['agency'];
        agencyTypes = documentSnapshot['agency'].toString();
        DocumentReference reference =
            FirebaseFirestore.instance.collection(agencyTypes).doc("los_banos");
        reference.snapshots().listen((querySnapshot) {
          numOfDispatchTotal = querySnapshot['numOfDispatch'];
          numOfAcceptedTotal = querySnapshot['numOfAccepted'];
          numOfCompletedTotal = querySnapshot['numOfCompleted'];
          if (numOfDispatchTotal > 0 ||
              numOfDispatchTotal >
                  globals.counter1) if (globals.agencyEntry == 1) {
                    Future(_showDialog);
                  }

          setState(() {
            if (agencyTypes == '1') {
              globals.counter1 = numOfDispatchTotal;
              globals.counter1A = numOfAcceptedTotal;
              globals.counter1C = numOfCompletedTotal;
            }

            if (agencyTypes == '2') {
              globals.counter1 = numOfDispatchTotal;
              globals.counter1A = numOfAcceptedTotal;
              globals.counter1C = numOfCompletedTotal;
            }

            if (agencyTypes == '3') {
              globals.counter1 = numOfDispatchTotal;
              globals.counter1A = numOfAcceptedTotal;
              globals.counter1C = numOfCompletedTotal;
            }

            if (agencyTypes == '4') {
              globals.counter1 = numOfDispatchTotal;
              globals.counter1A = numOfAcceptedTotal;
              globals.counter1C = numOfCompletedTotal;
            }
          });
        });
        // } else if (documentSnapshot['agency'] < 1) {
        //   setState(() {
        //     if (agencyTypes == '1') {
        //       globals.counter1 = 0;
        //       globals.counter1A = 0;
        //       globals.counter1C = 0;
        //     }

        //     if (agencyTypes == '2') {
        //       globals.counter1 = 0;
        //       globals.counter1A = 0;
        //       globals.counter1C = 0;
        //     }

        //     if (agencyTypes == '3') {
        //       globals.counter1 = 0;
        //       globals.counter1A = 0;
        //       globals.counter1C = 0;
        //     }

        //     if (agencyTypes == '4') {
        //       globals.counter1 = 0;
        //       globals.counter1A = 0;
        //       globals.counter1C = 0;
        //     }
        //   });
      } else {
        print("ERROR");
      }
    });
    globals.agencyEntry = 1;
  }

  void _showDialog() {
    Navigator.of(context).pushNamed('/task_page');
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     FlutterRingtonePlayer.playNotification(looping: true, volume: 10);

    //     return AlertDialog(
    //       // title: const Text("Emergency"),
    //       // content: const Text(
    //       //     "An explosion just happened in Beirut. Need immediate assistance."),
    //       actions: <Widget>[
    //         Stack(
    //             alignment: FractionalOffset.bottomRight +
    //                 const FractionalOffset(-0.1, -0.1),
    //             children: <Widget>[
    //               _ButterFlyAssetVideo(),
    //             ]),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Image.asset(
    //               'assets/images/medC.png',
    //               height: 100,
    //               width: 100,
    //             ),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             TextButton(
    //               child: const Text("Reject"),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //                 FlutterRingtonePlayer.stop();
    //                 // showSnackBar(context,
    //                 //     'You have Rejected an Alert. Zero Alerto coin earned this time.');
    //               },
    //               style: TextButton.styleFrom(
    //                 alignment: Alignment.centerLeft,
    //               ),
    //             ),
    //             TextButton(
    //               child: const Text("Accept"),
    //               onPressed: () {
    //                 Navigator.of(context).pushNamed('/recording_page',
    //                     arguments: globals.userType);
    //                 FlutterRingtonePlayer.stop();
    //               },
    //               style: TextButton.styleFrom(
    //                 alignment: Alignment.centerRight,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double height = MediaQuery.of(context).size.height;
    double iconheight3;
    double iconRow3;

    if (height > 600) {
      iconheight3 = 250;
      iconRow3 = 80;
    } else {
      iconheight3 = 150;
      iconRow3 = 60;
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
                height: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
//============================Ambulance============================================

            Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(iconRow3, iconheight3, 0, 0),
                child: getWidget()),
          ],
        ),
      ),
    );
  }

  Widget getWidget() {
    String agencyName = '';
    // agencyName = 'ambulance';
    if (globals.userType == 1) {
      agencyName = 'ambulance';
    }
    if (globals.userType == 2) {
      agencyName = 'police';
    }
    if (globals.userType == 3) {
      agencyName = 'firetruck';
    }
    if (globals.userType == 4) {
      agencyName = 'barangay';
    }
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
            child: Badge(
                showBadge: globals.counter1 == 0 ? false : true,
                position: BadgePosition.topEnd(top: 20, end: 20),
                padding: const EdgeInsets.all(10.0),
                badgeContent: Text(globals.counter1.toString(),
                    style: const TextStyle(color: Colors.white)),
                child: Badge(
                    showBadge: globals.counter1A == 0 ? false : true,
                    position: BadgePosition.topStart(top: 20, start: 20),
                    padding: const EdgeInsets.all(10.0),
                    badgeColor: Colors.yellow,
                    badgeContent: Text(globals.counter1A.toString(),
                        style: const TextStyle(color: Colors.black)),
                    child: Badge(
                        showBadge: globals.counter1C == 0 ? false : true,
                        position:
                            BadgePosition.bottomStart(bottom: 20, start: 20),
                        padding: const EdgeInsets.all(10.0),
                        badgeColor: Colors.green,
                        badgeContent: Text(globals.counter1C.toString(),
                            style: const TextStyle(color: Colors.white)),
                        child: GestureDetector(
                          onTap: () {
                            globals.userType = 1;
                            updateDispatch();
                            // globals.agencyType = 1;
                            // createTask();
                            // Navigator.of(context).pushNamed('/recording_page',
                            //     arguments: globals.agencyType);
                            // setState(() {
                            //   globals.counter1;
                            // });
                          },
                          onLongPress: () {
                            // globals.agencyType = 1;
                            // resetBookings();
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10,
                            shape: const CircleBorder(),
                            child: Container(
                              width: 240,
                              height: 240,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/$agencyName.png',
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
        ],
      ),
    );
  }
}

class _ButterFlyAssetVideo extends StatefulWidget {
  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<_ButterFlyAssetVideo> {
  late VideoPlayerController _controller;

  String agencyTypes = '0';
  late String userUUID;

  @override
  void initState() {
    super.initState();
    _taskVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _taskVideo() {
    agencyTypes = globals.userType.toString();
    print('-----------------------------------');
    print(agencyTypes);
    print('-----------------------------------');
    CollectionReference agency =
        FirebaseFirestore.instance.collection(agencyTypes);
    agency.doc('los_banos').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var userUUID = documentSnapshot['dispatchUUID'];
        globals.userID = userUUID.toString();
      } else {
        print('-------ERROR---------');
      }
    });
    // print('-----------------------------------');
    // print(globals.userID);
    // print('-----------------------------------');
    // agency
    //     .doc('los_banos')
    //     .collection('tasks')
    //     .doc(globals.userID)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     var video = documentSnapshot['video'].toString();

    //     if (video.isNotEmpty) {
    //       globals.videoUrl = video;
    //     } else {
    //       globals.videoUrl = 'https://www.youtube.com/watch?v=F1qm-WbDrbo';
    //     }
    //   } else {
    //     print('-------ERROR---------');
    //   }
    // });
    _controller = VideoPlayerController.asset('assets/videos/A-intro.mp4');
    // _controller = VideoPlayerController.network(globals.videoUrl);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          // const Text(''),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

//https://www.youtube.com/watch?v=F1qm-WbDrbo
//https://www.youtube.com/watch?v=PV27KNmwom4
