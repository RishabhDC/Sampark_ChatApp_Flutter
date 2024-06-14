import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sampark/Config/PagePath.dart';
import 'package:sampark/Config/Themes.dart';
import 'package:sampark/Pages/Auth/AuthPage.dart';
import 'package:sampark/Pages/HomePage/HomePage.dart';
import 'package:sampark/Pages/SplashPage/SplashPage.dart';
import 'package:sampark/Pages/WelcomePage/WelcomePage.dart';

import 'Controller/CallController.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      title: 'Sampark',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      getPages: pagePath,
      home: const SplashPage()
    );
  }
}
