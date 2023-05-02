import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 750,
      child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, position) {
            return MyHomePage(); //_buildPageItem(position);
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'LIju90wYqSQ',
    'XcX3IlRYHbg',
    'g0hybcgUwB0',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
        hideControls: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio: 3 / 2,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
        },
      ),
      builder: (context, player) => Scaffold(
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
}


  // final Uri _url = Uri.parse(
  //     'https://www.paypal.com/donate/?hosted_button_id=AGVVL4HCHZRH6');

//   Widget _buildPageItem(int index) {
//     return Container(
//       width: 100.0,
//       height: 220,
//       // margin: const EdgeInsets.only(left: 0, right: 0),
//       decoration: BoxDecoration(
//           // borderRadius: BorderRadius.circular(30),
//           color:
//               index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc)),
//       padding: const EdgeInsets.only(right: 10.0),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 13.0),
//                 child: Container(
//                   width: 35,
//                   height: 35,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 2, color: Colors.red),
//                     boxShadow: [
//                       BoxShadow(
//                           spreadRadius: 2,
//                           blurRadius: 10,
//                           color: Colors.black.withOpacity(0.1),
//                           offset: Offset(0, 10))
//                     ],
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: Image.asset(
//                         'assets/images/AA-logo.png',
//                       ).image,
//                     ),
//                   ),
//                 )),
//             const SizedBox(height: 15),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 13.0),
//               // Transform.rotate(
//               //   angle: 180 * math.pi / 180,
//               child: Opacity(
//                 opacity: 0.6,
//                 child: Icon(
//                   Icons.favorite,
//                   color: Colors.white,
//                   size: 35,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 13.0),
//               child: Text('2.5M', style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 15),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 13.0),
//               // Transform.rotate(
//               //   angle: 180 * math.pi / 180,
//               child: Opacity(
//                 opacity: 0.6,
//                 child: Icon(
//                   Icons.comment,
//                   color: Colors.white,
//                   size: 35,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 13.0),
//               child: Text('14.5K', style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 15),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 13.0),
//               child: Opacity(
//                 opacity: 0.6,
//                 child: Icon(
//                   Icons.share,
//                   color: Colors.white,
//                   size: 35,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 13.0),
//               child: Text('5.5K', style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 15),
//             // const Opacity(
//             //     opacity: 0.6,
//             //     child: PayPalButton(
//             //       paypalButtonId: "AGVVL4HCHZRH6",
//             //       donationText: "",
//             //     )),
//             // const Padding(
//             //   padding: EdgeInsets.symmetric(horizontal: 13.0),
//             //   child: Text('101.5K', style: TextStyle(color: Colors.white)),
//             // ),
//             // const SizedBox(height: 15),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 13.0),
//               child: Opacity(
//                 opacity: 0.6,
//                 child: Icon(
//                   Icons.upload,
//                   color: Colors.white,
//                   size: 35,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//           ]),
//     );
//   }
// }
