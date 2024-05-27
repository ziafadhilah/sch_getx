// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sch/view/absence/absence.dart';
import 'package:sch/view/announcement/announcement.dart';
import 'package:sch/view/home/home.dart';
import 'package:sch/view/profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    HomePage(),
    AbsencePage(),
    AnnouncementPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Color(0xff00A2B9),
        backgroundColor: Color(0xffF5F6FB),
        color: Colors.white,
        index: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
        items: [
          _selectedIndex == 0
              ? Image.asset(
                  'assets/icon/home.png',
                )
              : Image.asset('assets/icon/home_ico.png'),
          _selectedIndex == 1
              ? Image.asset(
                  'assets/icon/absence.png',
                )
              : Image.asset('assets/icon/absence_ico.png'),
          _selectedIndex == 2
              ? Image.asset(
                  'assets/icon/announce.png',
                )
              : Image.asset('assets/icon/announce_ico.png'),
          _selectedIndex == 3
              ? Image.asset(
                  'assets/icon/profile.png',
                )
              : Image.asset('assets/icon/profile_ico.png'),
        ],
      ),
    );
  }
}
