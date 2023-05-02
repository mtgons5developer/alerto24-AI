import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/firebase_auth_methods.dart';
import '../../utils/action_button.dart';
import '../../utils/expandable_fab.dart';
import '../../utils/showSnackBar.dart';

class ProfilePage3 extends StatefulWidget {
  const ProfilePage3({super.key});

  @override
  State<ProfilePage3> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage3> {
  // age/sex/e.contact-Relationship-contactnum/pre-existing conditions/marital status
  //Family Doctor Name-e.contact/Taking any medications, currently? Yes/No, If yes, please list it here
  //Pre-existing conditions: Pregnancy//Congestive Heart Failure/Hypertension/Epilepsy
  //A pre-existing condition is a health problem you had before the date that your new health coverage starts.
  //Epilepsy, cancer, diabetes, lupus, sleep apnea, and pregnancy are all examples of pre-existing conditions.

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creatinTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && user!.emailVerified) {
      await user!.sendEmailVerification();
      showSnackBar(context, "Verification Email has been sent.");

      // ScaffoldMessenger.of(context).showSnackBar(snackBar(
      //   backgroundcolor: Colors.black26,
      //   content: Text('Verification Email has been sent.',
      //   style: TextStyle(fontSize: 18.0, color: Colors.amber),
      //   ),);
      Scaffold(
        key: scaffoldKey,
        body: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('snack'),
              duration: const Duration(seconds: 1),
              action: SnackBarAction(
                label: 'ACTION',
                onPressed: () {},
              ),
            ));
          },
          child: const Text('SHOW SNACK'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        title: Text(
          "User Profile",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: ExpandableFab(distance: 120, children: [
        ActionButton(
          icon: const Icon(
            Icons.save,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {},
        ),
        ActionButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {},
        ),
        ActionButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            context.read<FirebaseAuthMethods>().signOut(context);
          },
        ),
      ]),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Colors.red,
              Colors.blue,
            ],
          )),
        ),
      ),
    );
  }
}
