import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:alerto24/globals.dart' as globals;

class TaskVideoPage extends StatelessWidget {
  const TaskVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 750,
      child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, position) {
            return _ButterFlyAssetVideo(); //_buildPageItem(position);
          }),
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
  late final double? width;
  late final double? height;

  @override
  void initState() {
    super.initState();
    _taskVideo();
  }

  @override
  void dispose() {
    if (_controller.value.isPlaying) _controller.pause();
    _controller.removeListener(_taskVideo);
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _taskVideo() {
    agencyTypes = globals.userType.toString();
    // print('-----------------------------------');
    // print(agencyTypes);
    // print('-----------------------------------');
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
    _controller = VideoPlayerController.asset('assets/videos/vid1.mp4');
    // _controller = VideoPlayerController.network(
    //     'https://firebasestorage.googleapis.com/v0/b/schooapp2022.appspot.com/o/Task%2FREC9009112549088490282.mp4?alt=media&token=7d562149-3251-4dc9-94ad-1628cfbcd878');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          // const Text(''),
          Container(
            // padding: const EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                VideoPlayer(_controller),
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
                Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(300, 0, 0, 0),
                    child: TextButton(
                      child: const Text('Accept',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/recording_page',
                            arguments: globals.agencyType);
                        _controller.dispose();
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/medC.png',
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: TextButton(
                      child: const Text(
                        'Reject',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/agency_account');
                        // _controller.dispose();
                        _controller.pause();
                      },
                    )),
              ],
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
