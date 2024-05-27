import 'dart:convert';

import 'package:get/get.dart';
import 'package:sch/controllers/login_controller.dart';
import 'package:sch/model/announcement_model.dart';
import 'package:sch/services/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Notice> notices = <Notice>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncement();
  }

  void fetchAnnouncement() async {
    try {
      final String? token = await LoginController().getToken();
      if (token != null) {
        Request request = Request(url: '/notice');
        request.getWithToken(token).then((value) {
          if (value.statusCode == 200) {
            Announcement announcement =
                Announcement.fromJson(jsonDecode(value.body));
            isLoading.value = false;
            notices.value = announcement.data.notices;
          } else {
            Get.snackbar('Alert', 'Gagal memuat pengumuman',
                snackPosition: SnackPosition.TOP);
          }
        });
      } else {
        Get.snackbar('Alert', 'Token tidak di temukan.',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Alert', 'Error $e', snackPosition: SnackPosition.TOP);
    }
  }

  Future<bool> isNoticeRead(String noticeId) {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getBool(noticeId) ?? false;
    });
  }

  void markNoticeAsRead(String noticeId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(noticeId, true);
    } catch (e) {
      print('Error marking notice as read: $e');
    }
  }
}
