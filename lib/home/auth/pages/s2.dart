import 'dart:io';

import 'package:alerto24/home/auth/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../utils/showSnackBar.dart';

class RegisterPage extends StatefulWidget {
  final String data;

  const RegisterPage({Key? key, required this.data}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  DatabaseReference reference = FirebaseDatabase.instance.ref().child('tasks');

  var _password = '';
  var _confirmPassword = '';

  void signUpUser() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (_password != _confirmPassword) {
          showSnackBar(
              context, "Password does not match. Please re-type again.");
        } else if (_password.isEmpty) {
          showSnackBar(
              context, "Password is required please enter a Password.");
        } else if (_password.length < 6) {
          showSnackBar(context, "Password must be atleast 6 or greater.");
        } else {
          FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
            email: emailController.text,
            password: _password,
            context: context,
          );
        }
      }
    } on SocketException catch (_) {
      showSnackBar(context, "Internet connection failed.");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/schooapp2022.appspot.com/o/images%2FAA-logo.png?alt=media&token=c5accba9-dd82-44a3-9743-05a570330598",
                              ))),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email:*',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: TextFormField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      _password = value.toString();
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password:*',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ))))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: TextFormField(
                                    controller: confirmPasswordController,
                                    obscureText: true,
                                    onChanged: (value) {
                                      _confirmPassword = value;
                                      print(_password);
                                      print(_confirmPassword);
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Confirm Password:*',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ))))),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: signUpUser,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.green[500],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          // Navigator.of(context).pushNamed('/home_page');
                          Navigator.of(context).pushNamed(
                            '/',
                            arguments: '',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            // color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
//================================================================================
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I\'m already a Member.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  void itemSelectionChanged(String? s) {
    // print(s);
  }
}
//https://www.youtube.com/watch?v=pAn3-cqJ9MM&t=346s