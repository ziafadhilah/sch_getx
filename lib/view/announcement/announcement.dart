// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/announcement_controller.dart';
import 'package:sch/model/announcement_model.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final AnnouncementController _announcementController =
      Get.put(AnnouncementController());

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
                  Text(
                    'No. : 123/MJS/08/2024',
                    style: TextStyle(fontSize: 14),
                  ),
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

  void _markAsRead(String noticeId) {
    _announcementController.markNoticeAsRead(noticeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      appBar: AppBar(
        title: Text(
          'Pengumuman',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,
        toolbarHeight: 70,
        // leading: IconButton(
        //   iconSize: 35,
        //   icon: Icon(Icons.chevron_left),
        //   onPressed: () {
        //     Get.offNamedUntil('/home', (route) => false);
        //   },
        // ),
      ),
      body: Obx(
        () => _announcementController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : _announcementController.notices.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada pengumuman',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _announcementController.notices.length,
                    itemBuilder: (context, index) {
                      Notice notice = _announcementController.notices[index];
                      final timeElapsed = _getTimeElapsed(notice.createDate);
                      final dateString = _getDateString(notice.createDate);
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
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notice.title,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                SizedBox(height: 10),
                                HtmlWidget(
                                  notice.notice.substring(0, 15) + '...',
                                ),
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
                                                    PlaceholderAlignment.middle,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 2),
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isRead
                                                        ? Color(0xFF5B616E)
                                                        : Colors.green,
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
                              _markAsRead(notice.noticeId);
                              _showAnnouncementDetails(context, notice);
                            },
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
