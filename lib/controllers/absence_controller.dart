// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:sch/controllers/login_controller.dart';
import 'package:sch/model/absence_model.dart';
import 'package:sch/services/http_services.dart';

class AbsenceController extends GetxController {
  RxBool isLoading = true.obs;
  late Map<String, dynamic> body;
  RxList<Attendance> attendance = <Attendance>[].obs;

  RxInt id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAbsence();
  }

  void fetchAbsence({String? srstudentId}) async {
    try {
      final token = await LoginController().getToken();
      if (token != null) {
        String url = '/daily';
        if (srstudentId != null) {
          url += '?srstudentId=$srstudentId';
        }
        Request request = Request(url: url);
        request.getWithToken(token).then((value) {
          if (value.statusCode == 200) {
            Absence absence = Absence.fromJson(jsonDecode(value.body));
            isLoading.value = false;
            attendance.value = absence.data.attendance;
          } else {
            Get.snackbar('Error', 'Backend error',
                snackPosition: SnackPosition.TOP);
          }
        });
      } else {
        Get.snackbar('Error', 'Token not found',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          snackPosition: SnackPosition.TOP);
    }
  }
}
