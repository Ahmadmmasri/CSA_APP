import 'package:csa_app/core/networking/firebaase-api.dart';
import 'package:csa_app/core/routing/app_router.dart';
import 'package:csa_app/csa_app.dart';
import 'package:csa_app/hot-restart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Request permission for notifications
  await FirebaseMessaging.instance.requestPermission();

  // Retrieve APNS token
  String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    print('APNS token: $apnsToken');
  } else {
    print('Failed to retrieve APNS token');
  }

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Run the app
  runApp(
    HotRestartController(child: CsaApp(appRouter: AppRouter())),
  );
}
