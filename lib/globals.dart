library alerto24.globals;

import 'package:firebase_auth/firebase_auth.dart';

int counter1 = 0;
int counter2 = 0;
int counter3 = 0;
int counter4 = 0;
int counter1A = 0;
int counter2A = 0;
int counter3A = 0;
int counter4A = 0;
int counter1C = 0;
int counter2C = 0;
int counter3C = 0;
int counter4C = 0;
int userType = 0;
int agencyEntry = 0;
int agencyType = 0;
int profileEntry = 0;
int book = 0;

double userLat = 14.1843025;
double userLong = 121.2573101; //Bel's Location
double dispatchLat = 14.1923461; //14.1823461;
double dispatchLong = 121.2477611; //121.2377611; //My Location

String first = '';
String middle = '';
String surname = '';
String gender = '';
String bday = '';
String address = '';
String barangay = '';
String cpnumber = '';
String postal = '';
String region = '';
String province = '';
String city = '';
String userID = '';
String videoUrl = '';

var currentUser = FirebaseAuth.instance.currentUser;
var uuid = currentUser!.uid;
var email = currentUser!.email;
double dispatchLatitude = dispatchLatitude;
var appVersion = 'App v0.0.13 Res v.0.0.11';
