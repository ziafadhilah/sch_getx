// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/version_controller.dart';
import 'package:sch/model/version_model.dart';

class VersionPage extends StatefulWidget {
  const VersionPage({super.key});

  @override
  State<VersionPage> createState() => _VersionPageState();
}

class _VersionPageState extends State<VersionPage> {
  final VersionController _versionController = Get.put(VersionController());
  String imageUrl = 'https://sch.sindigilive.com/uploads/images';

  @override
  void initState() {
    super.initState();
    _versionController.fetchVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          iconSize: 35,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (_versionController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (_versionController.settings.isEmpty) {
          return Center(
            child: Text('No data available'),
          );
        } else {
          Settings settings = _versionController.settings[0];
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xff00A2B9),
                ],
                stops: [0.2851, 1.0],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  '$imageUrl/${settings.photo}',
                  width: 120,
                ),
                // Image.asset(
                //   'assets/images/logo_1.png',
                //   width: 120,
                // ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/shadow.png',
                  width: 120,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  settings.sname,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Absensi Mobile Versi ${settings.updateversion} © ${DateTime.now().year}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
