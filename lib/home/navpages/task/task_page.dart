import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../../../utils/colors_utils.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _FetchDataState();
}

class _FetchDataState extends State<TaskPage> {
  Query dbRef = FirebaseDatabase.instance.ref().child('tasks');
  // DatabaseReference reference = FirebaseDatabase.instance.ref().child('tasks');

  late Timer _timer;
  late double _timeElapsed;

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  void initTimer() {
    _timeElapsed = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeElapsed += 1; // +1
      print("Time Elapsed: (sec" + _timeElapsed.toString());
      if (_timeElapsed == 5) {
        // exit(0);
        FlutterRingtonePlayer.playNotification();
      }

      if (_timeElapsed == 7) {
        // exit(0);
        FlutterRingtonePlayer.playNotification();
      }

      if (_timeElapsed == 9) {
        // exit(0);
        FlutterRingtonePlayer.playNotification();
      }

      if (_timeElapsed > 20) {
        // exit(0);
        _timeElapsed = 0;
      }
    });
  }
  //askID, status, userID, numOfDispatch, dispatchID, agencyType, dispatchLongitude, dispatchLatitude, userLongitude, userLangitude

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget listItem({required Map task}) {
    print(task['numOfDispatch']);
    //{dispatchLongitude:  , userLongitude:  , numOfDispatch: 1, userID: counterproductive-bridegroom61, userLangitude:  , agencyType: Ambulance,
    //dispatchLatitude:  , taskID: 26a7a0d7-8e70-44bd-90ad-70d5ed8a8e78, dispatchID: underprivileged-beating49, status: Pending, key: -NCTJv7piPDSD9gP0t9I}

    return Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        height: 70,
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/images/covid19.jpg'),
            // ),
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Colors.red,
            Colors.blue,
          ],
        )),
        // border: Border(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          if (task['covid19'] == 'YES')
            const SizedBox(
              child: Icon(Icons.coronavirus, size: 30.0),
            ),
          const SizedBox(width: 20),
          //agencyType
          if (task['agencyType'] == 'Ambulance')
            const SizedBox(
              child: Icon(Icons.health_and_safety, size: 30.0),
            ),
          const SizedBox(width: 20),
          if (task['agencyType'] == 'Police')
            const SizedBox(
              child: Icon(Icons.local_police_sharp,
                  size: 30.0, color: Colors.blue),
            ),
          const SizedBox(width: 20),
          if (task['agencyType'] == 'Barangay')
            const SizedBox(
              child:
                  Icon(Icons.local_activity, size: 30.0, color: Colors.brown),
            ),
          const SizedBox(width: 20),
          if (task['agencyType'] == 'Fire Truck')
            const SizedBox(
              child: Icon(Icons.fire_hydrant, size: 30.0, color: Colors.yellow),
            ),
          const SizedBox(width: 20),
          if (task['numOfDispatch'] == '1')
            const SizedBox(
              child: Icon(Icons.person, size: 30.0),
            ),
          if (task['numOfDispatch'] != '1')
            const SizedBox(
              child: Icon(Icons.group, size: 30.0),
            ),
          const SizedBox(width: 20),
          Text(
            task['numOfDispatch'],
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(width: 20),
          if (task['status'] == 'Pending')
            const SizedBox(
              child: Icon(Icons.pending, size: 30.0, color: Colors.red),
            ),
          const SizedBox(width: 20),
          if (task['status'] == 'Completed')
            const SizedBox(
              child: Icon(Icons.check, size: 30.0, color: Colors.green),
            ),
          const SizedBox(width: 20),
          if (task['status'] == 'Accepted')
            const SizedBox(
              child: Icon(Icons.online_prediction_rounded,
                  size: 30.0, color: Colors.yellow),
            ),
          const SizedBox(
            child: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
          ),
          // const SizedBox(width: 20),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            hexStringToColor("aa4b6b"),
            hexStringToColor("6b6b83"),
            hexStringToColor("3b8d99"),
          ]))),
        ),
        // floatingActionButton: ExpandableFab(distance: 120, children: [
        //   ActionButton(
        //     icon: const Icon(
        //       Icons.person,
        //       color: Colors.white,
        //       size: 35,
        //     ),
        //     onPressed: () {
        //       print('Send to selected Agency');
        //     },
        //   ),
        //   ActionButton(
        //     icon: const Icon(
        //       Icons.group,
        //       color: Colors.white,
        //       size: 35,
        //     ),
        //     onPressed: () {
        //       print('Send to All');
        //     },
        //   ),
        //   ActionButton(
        //     icon: const Icon(
        //       Icons.coronavirus_rounded,
        //       color: Colors.white,
        //       size: 35,
        //     ),
        //     onPressed: () {
        //       print(' COVID19');
        //     },
        //   ),
        // ]),
        body: SizedBox(
            height: double.infinity,
            child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map task = snapshot.value as Map;
                task['key'] = snapshot.key;
                return listItem(task: task);
              },
            )));
  }
}
