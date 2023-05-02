import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.taskKey}) : super(key: key);

  final String taskKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  final userNameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userSalaryController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('tasks');
    getTaskData();
  }

  void getTaskData() async {
    DataSnapshot snapshot = await dbRef.child(widget.taskKey).get();

    Map task = snapshot.value as Map;

    userNameController.text = task['assignedTo'];
    userAgeController.text = task['category'];
    userSalaryController.text = task['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Updating data in Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'assignedTo',
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'category',
                  hintText: 'Enter Your Age',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userSalaryController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'id',
                  hintText: 'Enter Your Salary',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> tasks = {
                    'assignedTo': userNameController.text,
                    'category': userAgeController.text,
                    'id': userSalaryController.text
                  };

                  dbRef
                      .child(widget.taskKey)
                      .update(tasks)
                      .then((value) => {Navigator.pop(context)});
                },
                child: const Text('Update Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
