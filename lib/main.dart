import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:alerto24/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alerto24/home/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'home/auth/pages/home_page.dart';
import 'package:alerto24/home/auth/firebase_auth_methods.dart';

// import 'home/utils/showSnackBar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

void _logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // List<CameraDescription> _cameras = <CameraDescription>[];

  try {
    WidgetsFlutterBinding.ensureInitialized();
    // _cameras = await availableCameras();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on CameraException catch (e) {
    _logError(e.code, e.description);
  }

  // await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alerto24 Emergency App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const MainPage();
    }
    return const HomePage();
  }
}
