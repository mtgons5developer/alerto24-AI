// import 'package:alerto24/home/utils/showSnackBar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../vdv/painters/face_detector_view.dart';
import 'navpages/homepage/home_page.dart';
import 'navpages/profile/profile.dart';
// import 'navpages/agencies/facepage.dart';
// import 'package:alerto24/globals.dart' as globals;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    // const USERHomePAGEWidget(),
    const FaceDetectorView(),
    // const AgencyHomePage(),
    const ProfilePage2()
  ];

  var currentIndex = 1;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          onTap: onTap,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30.0),
              label: '0',
            ),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.task, size: 30.0),
            //   label: '1',
            // ),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.upload, size: 30.0),
            //   label: '4',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.emergency,
                size: 40.0,
                color: Colors.red[900],
              ),
              label: '2',
            ),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.gps_fixed, size: 30.0),
            //   label: '3',
            // ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30.0),
              label: '4',
            ),
          ],
        ),
      );
}
