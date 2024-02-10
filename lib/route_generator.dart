import 'package:alerto24/home/navpages/homepage/home_page.dart';
import 'package:flutter/material.dart';
import 'home/auth/pages/s2.dart';
import 'home/main_page.dart';
import 'home/navpages/agencies/camera_page.dart';
import 'home/navpages/agencies/task_page.dart';
import 'home/navpages/recording/booking.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/second':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RegisterPage(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/recording_page':
        // return MaterialPageRoute(builder: (_) => const OrderTrackingPage());
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => OrderTrackingPage(
              data: args.toString(),
            ),
          );
        }
        return _errorRoute();

      case '/task_page': //CameraApp
        return MaterialPageRoute(builder: (_) => const TaskVideoPage());

      case '/camera_page': //CameraApp
        return MaterialPageRoute(builder: (_) => const CameraApp());

      case '/agency_account': //CameraApp
        return MaterialPageRoute(builder: (_) => const MainPage());
      // if (args is int) {
      //   return MaterialPageRoute(
      //     builder: (_) => OrderTrackingPage(
      //       data: args.toString(),
      //     ),
      //   );
      // }
      // return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
