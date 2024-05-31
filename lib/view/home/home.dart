// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, sort_child_properties_last, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/absence_controller.dart';
import 'package:sch/controllers/announcement_controller.dart';
import 'package:sch/controllers/profile_controller.dart';
import 'package:sch/model/announcement_model.dart';
import 'package:sch/model/login_model.dart';
import 'package:sch/model/profile_model.dart';
import 'package:sch/view/absence/absence_history.dart';
import 'package:sch/view/profile/detail_profile_children.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileController _profileController = ProfileController();
  final AnnouncementController _announcementController =
      Get.put(AnnouncementController());
  final AbsenceController _absenceController = Get.put(AbsenceController());

  List<String> videos = [
    'youtu.be/yHH5MBHRGiA',
    // 'Video 2',
  ];
  String imageUrl = 'https://smpn1sumber-153.com/uploads/images';

  String _getTimeElapsed(DateTime createDate) {
    final now = DateTime.now();
    final difference = now.difference(createDate);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  String _getDateString(DateTime createDate) {
    final now = DateTime.now();
    if (now.year == createDate.year &&
        now.month == createDate.month &&
        now.day == createDate.day) {
      return 'Hari Ini';
    } else {
      return '${createDate.day.toString().padLeft(2, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.year}';
    }
  }

  @override
  void initState() {
    super.initState();
    _announcementController.fetchAnnouncement();
    _profileController.fetchProfile();
  }

  void _isRead(String noticeId) {
    _announcementController.markNoticeAsRead(noticeId);
  }

  void _showChildrenDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width - 80,
            child: SingleChildScrollView(
              child: _buildChildrenList(),
            ),
          ),
        );
      },
    );
  }

  void _showAnnouncementDetails(BuildContext context, Notice notice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width - 80,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'PENGUMUMAN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  // Text(
                  //   'No. : 123/MJS/08/2024',
                  //   style: TextStyle(fontSize: 14),
                  // ),
                  ListTile(
                    title: Text(
                      'Perihal : ${notice.title}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        HtmlWidget(notice.notice),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChildrenList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _profileController.childrens.length,
      itemBuilder: (BuildContext context, int index) {
        Children child = _profileController.childrens[index];
        String photoUrl = '${imageUrl}/${child.photo}';
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              Get.to(
                DetailProfileChildrenPage(
                  children: child,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/education_bg.png'),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(10),
                // color: Color(0xFF00A2B9),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.network(
                        Uri.parse(photoUrl).isAbsolute
                            ? photoUrl
                            : 'https://via.placeholder.com/70',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Siswa',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Text(
                              child.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Kelas ${child.srclasses}-${child.srsection}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40,
            bottom: 15,
          ),
          height: 130,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/education_bg.png'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            // color: Color(0xFF00A2B9),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Data',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Siswa',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  // width: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _showChildrenDetail(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Lihat',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          // top: 10,
          right: 5,
          bottom: 15,
          child: Image.asset(
            'assets/images/education.png',
            height: 170,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: 200,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Pengumuman'),
                Tab(text: 'Video dan Artikel'),
              ],
              labelColor: Colors.black, // Color of the selected tab label
              unselectedLabelColor:
                  Colors.grey, // Color of unselected tab labels
              indicatorColor: Colors.blue,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(
                    () {
                      List<Notice> firstNotice =
                          _announcementController.notices.isNotEmpty
                              ? [_announcementController.notices.first]
                              : [];
                      return firstNotice.isNotEmpty
                          ? ListView.builder(
                              itemCount: firstNotice.length,
                              itemBuilder: (context, index) {
                                Notice notice =
                                    _announcementController.notices[index];
                                final timeElapsed =
                                    _getTimeElapsed(notice.createDate);
                                final dateString =
                                    _getDateString(notice.createDate);
                                return FutureBuilder<bool>(
                                  future: _announcementController
                                      .isNoticeRead(notice.noticeId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    final isRead = snapshot.data ?? false;
                                    return ListTile(
                                      title: Text(
                                        notice.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          HtmlWidget(
                                              notice.notice.substring(0, 15) +
                                                  '...'),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: isRead
                                                          ? 'Sudah dibaca '
                                                          : 'Belum dibaca ',
                                                      style: TextStyle(
                                                        color: isRead
                                                            ? Color(0xFF5B616E)
                                                            : Colors.green,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      children: [
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        2),
                                                            width: 8,
                                                            height: 8,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: isRead
                                                                  ? Color(
                                                                      0xFF5B616E)
                                                                  : Colors
                                                                      .green,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TextSpan(
                                                      text: timeElapsed,
                                                      style: TextStyle(
                                                        color: isRead
                                                            ? Color(0xFF5B616E)
                                                            : Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                dateString,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: isRead
                                                      ? Color(0xFF5B616E)
                                                      : Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                      onTap: () {
                                        _isRead(notice.noticeId);
                                        _showAnnouncementDetails(
                                            context, notice);
                                      },
                                    );
                                  },
                                );
                              },
                            )
                          : Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 20),
                                child: Image.asset(
                                  'assets/images/no_announcements.png',
                                  width: 150,
                                ),
                              ),
                            );
                    },
                  ),
                  ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextButton(
                          child: Text('Video Tutorial'),
                          onPressed: () {
                            launchBrowser(videos[index]);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  dynamic launchBrowser(String url) async {
    try {
      Uri test = Uri(
        scheme: 'https',
        path: url,
      );
      await launchUrl(test);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildAbsence() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Text(
            'Absensi',
            style: TextStyle(color: Color(0xFF5B616E)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 20, left: 15, top: 5),
          width: MediaQuery.of(context).size.width,
          height: 110,
          child: Obx(
            () => _profileController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _profileController.childrens.length,
                    itemBuilder: (context, index) {
                      final Children child =
                          _profileController.childrens[index];
                      String photoUrl = '${imageUrl}/${child.photo}';
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            DateTime lastDate =
                                _absenceController.getLastAttendanceDate();
                            Get.to(
                              AbsenceHistoryPage(),
                              arguments: {
                                'srstudentId': child.srstudentId,
                                'selectedDate': lastDate,
                              },
                            );
                          },
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(0xffFEEECB),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      Uri.parse(photoUrl).isAbsolute
                                          ? photoUrl
                                          : 'https://via.placeholder.com/70',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          child: Text(
                                            child.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Kelas ${child.srclasses} - ${child.srsection}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff757575),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text('')
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 8,
          shadowColor: Colors.black,
          toolbarHeight: 100,
          title: Obx(() {
            String username = _profileController.profiles.isNotEmpty
                ? _profileController.profiles[0].username.toString()
                : '';

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Hallo,',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          }),
          actions: [
            IconButton(
              icon: Obx(() {
                String photoUrl = _profileController.profiles.isNotEmpty
                    ? '${imageUrl}/${_profileController.profiles[0].photo}'
                    : '';

                return CircleAvatar(
                  backgroundImage: NetworkImage(Uri.parse(photoUrl).isAbsolute
                      ? photoUrl
                      : 'https://via.placeholder.com/150'),
                  onBackgroundImageError: (_, __) {
                    // Optional: You can handle the error case here if needed
                  },
                );
              }),
              onPressed: () {
                Get.toNamed('/profile');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildCard(),
          _buildAbsence(),
          _buildTabs(),
        ],
      ),
    );
  }
}
