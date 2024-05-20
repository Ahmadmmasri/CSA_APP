import 'package:csa_app/core/networking/firebaase-api.dart';
import 'package:csa_app/core/routing/app_router.dart';
import 'package:csa_app/csa_app.dart';
import 'package:csa_app/hot-restart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // if (Platform.isIOS) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "Api key here",
  //       appId: "App id here",
  //       messagingSenderId: "Messaging sender id here",
  //       projectId: "project id here",
  //     ),
  //   );
  // } else {
  //   await Firebase.initializeApp();
  // }
  //await FirebaseApi().initNotification();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    HotRestartController(child: CsaApp(appRouter: AppRouter())),
  );
}
