import 'package:alerto24/home/auth/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage11 extends StatefulWidget {
  final String data;

  const RegisterPage11({Key? key, required this.data}) : super(key: key);

  @override
  State<RegisterPage11> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage11> {
  //text controllers
  final TextEditingController _priceController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // final TextEditingController firstNameController = TextEditingController();
  // final TextEditingController middleNameController = TextEditingController();
  // final TextEditingController surNameController = TextEditingController();
  // final TextEditingController suffixController = TextEditingController();
  // final TextEditingController contactNumController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController postalCodeController = TextEditingController();
  // final TextEditingController regionController = TextEditingController();
  // final TextEditingController provinceController = TextEditingController();
  // final TextEditingController cityController = TextEditingController();
  // final TextEditingController barangayController = TextEditingController();

  // String? mtoken = " ";

  // var selectedType;
  // List<String> _addressLocation = <String>[
  //   '1',
  //   '2',
  //   '3',
  //   '4',
  // ];

  // void saveToken(String token) async {
  //   await FirebaseFirestore.instance.collection("users").doc("Player3").set({
  //     'token': token,
  //   });
  // }

  // @override
  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       //trigger a setState function, then we can update our UI.
  //       mtoken = token; //get token and save it to a variable.
  //       print('My token is $mtoken');
  //     });
  //     saveToken(token!);
  //   });
  // }

  // @override
  // void requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: false,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission.');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional..');
  //   } else {
  //     print('User declined or has not accepted permission.');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  // requestPermission();
  // getToken();
  // initInfo();
  // }

  // initInfo() {
  //   var androidInitialize =
  //       const AndroidInitializationSettings(('@mipmap/ic_launcher'));
  //   var iOSInitialize = const IOSInitializationSettings();
  //   var initializationsSettings =
  //       InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  //   flutterLocalNotificationsPlugin.initialize(initializationsSettings,
  //       onSelectNotification: (String? payload) async {
  //     try {
  //       if (payload != null && payload.isNotEmpty) {
  //       } else {}
  //     } catch (e) {}
  //     return;
  //   });

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     print("......onMessage......");
  //     print(
  //         "OnMessage: ${message.notification?.title}/${message.notification?.body}}");

  //     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
  //       message.notification!.body.toString(),
  //       htmlFormatBigText: true,
  //       contentTitle: message.notification!.title.toString(),
  //       htmlFormatContentTitle: true,
  //     );
  //     AndroidNotificationDetails androidPlatformChannelSpecifics =
  //         AndroidNotificationDetails(
  //       'dbfood',
  //       'dbfood',
  //       importance: Importance.high,
  //       styleInformation: bigTextStyleInformation,
  //       priority: Priority.high,
  //       playSound: true,
  //       sound: const RawResourceAndroidNotificationSound('notification'),
  //     );
  //     NotificationDetails platformChannelSpecifics = NotificationDetails(
  //         android: androidPlatformChannelSpecifics,
  //         iOS: const IOSNotificationDetails());
  //     await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
  //         message.notification?.body, platformChannelSpecifics,
  //         payload: message.data['body']);
  //   });
  // }

  // Future onSelectNotification(String? payload) async {
  //   try {
  //     if (payload != null && payload.isNotEmpty) {
  //     } else {}
  //   } catch (e) {}
  //   return;
  // }
  // }

  // void sendPushMessage(String token, String body, String title) async {
  //   try {
  //     await http.post(
  //       //header
  //       Uri.parse('http://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type:': "application/json",
  //         'Authorization':
  //             'AAAABhl23yA:APA91bHOq48XLXJRObNkph_dh7qV_MzzdnTp-LGUIqAvaE1jaIbx8xBYjb24CY3xi8ZwjSfgC7vOOOwzuNTgkXfGJk0Xvd_YvSZWU76Mqz7zrMBhdqD1XaSR4HJFfU7RIjFdhGiUsiVm',
  //       },
  //       //data and will open to a new page
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           'priority': 'high',
  //           'data': <String, dynamic>{
  //             //channel name
  //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //             'status': 'done',
  //             'title': title,
  //           },
  //           "notification": <String, dynamic>{
  //             "title": title,
  //             "body": body,
  //             "android_channel_id": "dbfood"
  //           },
  //           "to": token,
  //           "direct_boot_ok": false,
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("error push notification");
  //     }
  //   }
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    // firstNameController.dispose();
    // middleNameController.dispose();
    // surNameController.dispose();
    // suffixController.dispose();
    // contactNumController.dispose();
    // _priceController.dispose();
    // addressController.dispose();
    // postalCodeController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
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
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                              // "",
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
                            hintText: 'Email*',
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
                          // validator: (String value) {
                          //   passwordController = value;
                          // if (value.isEmpty) {
                          //   return "Please Enter New Password";
                          // } else if (value.length < 6 {
                          //   return "Password must be atleast 6 characters.";
                          // } else {
                          //   return null;
                          // }
                          // },

                          // controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password*',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: TextFormField(
                  //         controller: confirmPasswordController,
                  //         obscureText: true,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Confirm Password*',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: TextField(
                  //         controller: firstNameController,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'First Name*',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: TextField(
                  //         controller: middleNameController,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Middle Name*',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: TextField(
                  //         controller: surNameController,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Surname*',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: TextField(
                  //         controller: suffixController,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Suffix ex. Jr, III, Sr (optional)',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: TextField(
                  //         controller: contactNumController,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Contact Number:',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                            hintText: 'Region*',
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
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Province*',
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
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Municipality*',
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
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Baranggay*',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: TextField(
                  //         controller: addressController,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Address:',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                            hintText: 'Postal Code*',
                          ),
                        ),
                      ),
                    ),
                  ),
//========================================================================
                  // DropdownButton(
                  //     value: selectedType,
                  //     isExpanded: false,
                  //     hint: const Text(
                  //       "Select Region ex. IV-A (CALABARZON)",
                  //     ),
                  //     icon: const Icon(Icons.arrow_downward),
                  //     elevation: 10,
                  //     items: _addressLocation
                  //         //             items: users.map((User user) {
                  //         .map((dynamic value) => DropdownMenuItem(
                  //               value: value,
                  //               child: Text(
                  //                 value,
                  //                 style: const TextStyle(
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //             ))
                  //         .toList(),
                  //     onChanged: (newmenu) {
                  //       setState(() {
                  //         selectedType = _addressLocation;
                  //       });
                  //     }),
//========================================================================
                  // DropdownButton(
                  //     value: selectedType,
                  //     isExpanded: false,
                  //     hint: const Text(
                  //       "Select a City*",
                  //     ),
                  //     icon: const Icon(Icons.arrow_downward),
                  //     elevation: 10,
                  //     items: _addressLocation
                  //         .map((dynamic value) => DropdownMenuItem(
                  //               value: value,
                  //               child: Text(
                  //                 value,
                  //                 style: TextStyle(fontWeight: FontWeight.bold),
                  //               ),
                  //             ))
                  //         .toList(),
                  //     onChanged: (newmenu) {
                  //       setState(() {
                  //         selectedType = _addressLocation;
                  //       });
                  //     }),
//========================================================================
                  // DropdownButton(
                  //     value: selectedType,
                  //     isExpanded: false,
                  //     hint: const Text(
                  //       "Select a Province*",
                  //     ),
                  //     icon: Icon(Icons.arrow_downward),
                  //     elevation: 10,
                  //     items: _addressLocation
                  //         .map((dynamic value) => DropdownMenuItem(
                  //               value: value,
                  //               child: Text(
                  //                 value,
                  //                 style: TextStyle(fontWeight: FontWeight.bold),
                  //               ),
                  //             ))
                  //         .toList(),
                  //     onChanged: (newmenu) {
                  //       setState(() {
                  //         selectedType = _addressLocation;
                  //       });
                  //     }),
//========================================================================
                  // DropdownButton(
                  //     value: selectedType,
                  //     isExpanded: false,
                  //     hint: new Text(
                  //       "Select a Region*",
                  //     ),
                  //     icon: Icon(Icons.arrow_downward),
                  //     elevation: 10,
                  //     items: _addressLocation
                  //         .map((dynamic value) => DropdownMenuItem(
                  //               value: value,
                  //               child: Text(
                  //                 value,
                  //                 style: TextStyle(fontWeight: FontWeight.bold),
                  //               ),
                  //             ))
                  //         .toList(),
                  //     onChanged: (newmenu) {
                  //       setState(() {
                  //         selectedType = _addressLocation;
                  //       });
                  //     }),
//========================================================================
//========================================================================
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'I\'m already a Member.',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                ],
              )),
            ))),
      );
}

// //"brgy_code":"012801001",
// //"brgy_name":"Adams (Pob.)",
// //"city_code":"012801",
// //"province_code":"0128",
// //"region_code":"01"
