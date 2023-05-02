import 'package:alerto24/home/utils/action_button.dart';
import 'package:alerto24/home/utils/expandable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:video_player/video_player.dart';

class TikTokVideos extends StatefulWidget {
  const TikTokVideos({super.key});

  @override
  State<TikTokVideos> createState() => _TikTokVideosState();
}

class _TikTokVideosState extends State<TikTokVideos> {
  // final asset = 'assets/Highway_accident.mp4';
  // late VideoPlayerController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = VideoPlayerController.asset(asset)
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..initialize().then((_) => controller.play());
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return VideoPlayerWidget(controller: controller);
  // }
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, position) {
            return _buildPageItem(position);
          }),
    );
  }
}

Widget _buildPageItem(int index) {
  return Scaffold(
    body: SafeArea(
      child: ExpandableFab(
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
    ),
    // height: 220,
    // margin: EdgeInsets.only(left: 5, right: 5),
    // decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(30),
    //     color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc)),
  );
}
