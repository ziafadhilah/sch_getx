// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/layouts/menu_nav.dart';
import 'package:sch/splash.dart';
import 'package:sch/view/absence/absence.dart';
import 'package:sch/view/login/login.dart';
import 'package:sch/view/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sekolah App',
      home: SplashPage(),
      // initialRoute: '/login',
      getPages: [
        GetPage(name: '/home', page: () => Dashboard()),
        GetPage(name: '/absence', page: () => AbsencePage()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/profile', page: () => ProfilePage()),
      ],
    );
  }
}
