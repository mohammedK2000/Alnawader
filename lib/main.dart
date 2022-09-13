import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

import 'package:purshases/utiles.dart';

import 'home.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 
}
void main() async{
    await WidgetsFlutterBinding.ensureInitialized();
   Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
      HttpOverrides.global = new MyHttpOverrides();

     SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());

 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
             toastTheme: ToastThemeData(
                background:primarycolor, textColor: Colors.white),
      child: MaterialApp(
        title: 'النوادر',
        theme: ThemeData(
         fontFamily: 'Cairo',
          primarySwatch: Colors.orange,
        ),
        home: MyHomePage(title: 'نوادر'),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
