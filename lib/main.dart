// import 'dart:async';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:alerto24/route_generator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:alerto24/home/main_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'firebase_options.dart';
// import 'home/auth/pages/home_page.dart';
// import 'package:alerto24/home/auth/firebase_auth_methods.dart';

// // import 'package:alerto24/vdv/painters/entity_extraction_view.dart';
// // import 'package:alerto24/vdv/painters/language_identifier_view.dart';
// // import 'package:alerto24/vdv/painters/language_translator_view.dart';
// // import 'package:alerto24/vdv/painters/smart_reply_view.dart';
// // import 'package:alerto24/vdv/painters/face_detector_view.dart';

// // import 'home/utils/showSnackBar.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   // If you're going to use other Firebase services in the background, such as Firestore,
// //   // make sure you call `initializeApp` before using other Firebase services.
// //   await Firebase.initializeApp();

// //   print("Handling a background message: ${message.messageId}");
// // }

// List<CameraDescription> cameras = [];


// void _logError(String code, String? message) {
//   if (message != null) {
//     print('Error: $code\nError Message: $message');
//   } else {
//     print('Error: $code');
//   }
// }

// Future<void> main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // List<CameraDescription> _cameras = <CameraDescription>[];

//   try {
//     WidgetsFlutterBinding.ensureInitialized();
//     // _cameras = await availableCameras();
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } on CameraException catch (e) {
//     _logError(e.code, e.description);
//   }

//   // await FirebaseMessaging.instance.getInitialMessage();
//   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   cameras = await availableCameras();
  
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<FirebaseAuthMethods>(
//           create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
//         ),
//         StreamProvider(
//           create: (context) => context.read<FirebaseAuthMethods>().authState,
//           initialData: null,
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Alerto24 Emergency App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: const AuthWrapper(),
//         initialRoute: '/',
//         onGenerateRoute: RouteGenerator.generateRoute,
//       ),
//     );
//   }
// }

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();

//     if (firebaseUser != null) {
//       return const MainPage();
//     }
//     return const HomePage();
//   }
// }

//QmRdWoUjyE7fRm6gnvHHwM7tA3hLuZFYeUJgQVb5bFZ64z
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> downloadFileFromIPFS(String cid, String filePath) async {
  final url = 'https://ipfs.io/ipfs/$cid';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    String filename;
    final contentDisposition = response.headers['content-disposition'];
    if (contentDisposition != null && contentDisposition.contains('filename=')) {
      final startIndex = contentDisposition.indexOf('filename=');
      filename = contentDisposition.substring(startIndex + 9);
    } else {
      filename = Uri.parse(url).pathSegments.last;
    }

    final file = File('$filePath/$filename');
    await file.writeAsBytes(response.bodyBytes);
    print('File downloaded successfully! Filename: $filename');
    return filename;
  } else {
    throw Exception('Failed to download file from IPFS');
  }
}

void main() async {
  const cid = 'QmRdWoUjyE7fRm6gnvHHwM7tA3hLuZFYeUJgQVb5bFZ64z';
  const filePath = 'Downloads/';
  final filename = await downloadFileFromIPFS(cid, filePath);
  print('Downloaded file: $filename');
}
