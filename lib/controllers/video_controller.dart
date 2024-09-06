import 'dart:convert';

import 'package:get/get.dart';
import 'package:sch/controllers/login_controller.dart';
import 'package:sch/model/video_model.dart';
import 'package:sch/services/http_services.dart';

class VideoController extends GetxController {
  RxBool isLoading = true.obs;

  late Map<String, dynamic> body;
  RxList<VideoElement> videos = <VideoElement>[].obs;

  RxInt id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideo();
  }

  void fetchVideo() async {
    try {
      final String? token = await LoginController().getToken();
      if (token != null) {
        Request request = Request(url: '/video');
        request.getWithToken(token).then((value) {
          if (value.statusCode == 200) {
            Video video = Video.fromJson(jsonDecode(value.body));
            isLoading.value = false;
            videos.value = video.data.videos;
          } else {
            Get.snackbar('Alert', 'Gagal memuat video.',
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
}
