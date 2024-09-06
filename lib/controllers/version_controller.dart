import 'dart:convert';

import 'package:get/get.dart';
import 'package:sch/controllers/login_controller.dart';
import 'package:sch/model/version_model.dart';
import 'package:sch/services/http_services.dart';

class VersionController extends GetxController {
  RxBool isLoading = true.obs;

  late Map<String, dynamic> body;
  RxList<Settings> settings = <Settings>[].obs;

  RxInt id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVersion();
  }

  void fetchVersion() async {
    try {
      Request request = Request(url: '/master');
      final response = await request.get(); // Menggunakan get dari Request

      if (response.statusCode == 200) {
        Version version = Version.fromJson(jsonDecode(response.body));
        isLoading.value = false;
        settings.value = [version.data.settings];
      } else {
        Get.snackbar('Alert', 'Gagal memuat versi.',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Alert', 'Error $e', snackPosition: SnackPosition.TOP);
    }
  }
}
