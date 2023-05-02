import 'package:flutter/material.dart';
import '../../../utils/colors_utils.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
              hexStringToColor("aa4b6b"),
              hexStringToColor("6b6b83"),
              hexStringToColor("3b8d99"),
            ]))),
            // bottom: TabBar(
            //   indicatorColor: Colors.white,
            //   indicatorWeight: 5,
            //   tabs: [
            //     Tab(
            //         icon: Icon(
            //       Icons.health_and_safety,
            //       color: Colors.red[900],
            //       size: 40,
            //     )),
            //     Tab(
            //         icon: Icon(
            //       Icons.local_police,
            //       size: 40,
            //       color: Colors.blue[900],
            //     )),
            //     Tab(
            //         icon: Icon(
            //       Icons.local_activity,
            //       size: 40,
            //       color: Colors.brown[500],
            //     )),
            //     Tab(
            //         icon: Icon(
            //       Icons.fire_extinguisher,
            //       size: 40,
            //       color: Colors.yellow[500],
            //     )),
            //   ],
            // ),
            elevation: 10,
            titleSpacing: 10,
          ),
          // body: const TabBarView(
          //   children: [
          //     USERHomePAGEWidget3(),
          //   ],
          // ),
        ),
      );

  Widget buildPage(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 28),
        ),
      );
}
