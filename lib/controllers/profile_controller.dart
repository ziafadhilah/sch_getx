// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages, unnecessary_new

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sch/model/profile_model.dart';
import 'package:sch/controllers/login_controller.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sch/services/http_services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController {
  String? errorMessage;
  RxBool isLoading = true.obs;
  late Map<String, dynamic> body;
  RxList<ProfileItem> profiles = <ProfileItem>[].obs;
  RxList<Children> childrens = <Children>[].obs;

  // Untuk Parents
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController fatherJobController = TextEditingController();
  final TextEditingController motherController = TextEditingController();
  final TextEditingController motherJobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  RxInt id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final token = await LoginController().getToken();
      if (token != null) {
        Request request = Request(url: '/profile');
        request.getWithToken(token).then((value) {
          if (value.statusCode == 200) {
            final decodedResponse = jsonDecode(value.body);
            final profile =
                ProfileItem.fromJson(decodedResponse['data']['profile']);
            final List<dynamic> childrenData =
                decodedResponse['data']['childrens'];
            final List<Children> children =
                childrenData.map((data) => Children.fromJson(data)).toList();

            // Set nilai text controller untuk parent
            nameController.text = profile.name;
            fatherController.text = profile.fatherName;
            fatherJobController.text = profile.fatherProfession;
            motherController.text = profile.motherName;
            motherJobController.text = profile.motherProfession;
            addressController.text = profile.address;
            emailController.text = profile.email;
            phoneController.text = profile.phone;

            profiles.add(profile);
            childrens.addAll(children);

            isLoading.value = false;
          } else {
            Get.snackbar(
              'Alert',
              'Backend Error',
              snackPosition: SnackPosition.TOP,
            );
          }
        });
      } else {
        Get.snackbar(
          'Alert',
          'Token Not Found',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Alert',
        'Error $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> saveProfileData() async {
    try {
      final token = await LoginController().getToken();
      if (token != null) {
        Request request = Request(
            url:
                '/profile/edit/${profiles[0].usertypeId}/${profiles[0].username}/0');
        final Map<String, dynamic> updatedProfile = {
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'father_name': fatherController.text,
          'mother_name': motherController.text,
          'father_profession': fatherJobController.text,
          'mother_profession': motherJobController.text,
          'address': addressController.text,
          'usertypeID': profiles[0].usertypeId,
          'parentsID': profiles[0].parentsId,
          'photo': profiles[0].photo,
        };

        String jsonBody = jsonEncode(updatedProfile);

        // final Map<String, dynamic> requestBody = updatedProfile.toJson();
        request.patch(token, body: jsonBody).then((value) {
          if (value.statusCode == 200) {
            Get.snackbar('Alert', 'Data berhasil tersimpan',
                snackPosition: SnackPosition.TOP);
            isLoading.value = false;
            refreshProfile();
          } else {
            Get.snackbar('Alert', 'Gagal memperbarui profil!',
                snackPosition: SnackPosition.TOP);
          }
        });
      } else {
        throw Get.snackbar('Error', 'Token tidak tersedia',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      throw throw Get.snackbar('Error', '$e', snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> saveChildrenData(Children editedChild) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    try {
      final token = await LoginController().getToken();
      if (token != null) {
        Request request = Request(
            url:
                '/profile/edit/${editedChild.usertypeId}/${editedChild.username}/${editedChild.srschoolyearId}');

        final Map<String, dynamic> editedChildData = {
          'name': editedChild.name,
          'pob': editedChild.pob,
          'dob': formatter.format(editedChild.dob),
          'sex': editedChild.sex,
          'phone': editedChild.phone,
          'email': editedChild.email,
          'address': editedChild.address,
          'religion': editedChild.religion,
          'bloodgroup': editedChild.bloodgroup,
        };

        // Encode data anak yang diedit menjadi JSON
        String jsonBody = jsonEncode(editedChildData);

        // Lakukan PATCH request untuk menyimpan data anak yang diedit
        request.patch(token, body: jsonBody).then((value) {
          if (value.statusCode == 200) {
            Get.snackbar('Sukses', 'Data anak berhasil diperbarui',
                snackPosition: SnackPosition.TOP);
            isLoading.value = false;
            refreshProfile();
          } else {
            Get.snackbar('Error', 'Gagal menyimpan data anak',
                snackPosition: SnackPosition.TOP);
          }
        });
      } else {
        throw Get.snackbar('Error', 'Token tidak tersedia',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      throw Get.snackbar('Error', '$e', snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword,
      String rePassword, String username) async {
    final LoginController _loginController = Get.put(LoginController());
    try {
      final token = await LoginController().getToken();
      if (token != null) {
        // Validasi password baru
        if (newPasswordController.text != rePasswordController.text) {
          Get.snackbar(
            'Error',
            'Password baru tidak cocok',
            snackPosition: SnackPosition.TOP,
          );
          return;
        }
        Request request = Request(url: '/signin/cpassword/$username');
        final Map<String, dynamic> passwordData = {
          'old_password': oldPassword,
          'new_password': newPassword,
          're_password': rePassword,
        };
        String jsonBody = jsonEncode(passwordData);
        request.postChange(body: jsonBody).then((value) {
          if (value.statusCode == 200) {
            Get.snackbar(
              'Success',
              'Password berhasil diubah, Silahkan login kembali.',
              snackPosition: SnackPosition.TOP,
            );
            // Reset semua field input
            oldPasswordController.clear();
            newPasswordController.clear();
            rePasswordController.clear();
            _loginController.logoutUser();
            Get.offAllNamed('/login');
          } else {
            Get.snackbar(
              'Error',
              'Gagal mengubah password',
              snackPosition: SnackPosition.TOP,
            );
          }
        });
      } else {
        throw Exception('Error: Token not found');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<bool> uploadImage({
    required String usertypeID,
    required String username,
    required String imagePath,
  }) async {
    final LoginController _loginController = Get.put(LoginController());
    try {
      final url = Uri.parse(
          'https://sch.sindigilive.com/api/v10/profile/photoupload/$usertypeID/$username');
      final token = await _loginController.getToken();

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
        // Kompres gambar sebelum mengunggah
        File compressedImage = await compressImage(File(imagePath));

        var file = await http.MultipartFile.fromPath(
          'photo',
          compressedImage.path,
          contentType: MediaType.parse(
              'image/${getFileExtension(compressedImage.path)}'),
        );
        request.files.add(file);
      } else {
        Get.snackbar(
          'Error',
          'Gagal upload foto',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return true;
      } else {
        final responseData = jsonDecode(response.body);
        String errorMessage = responseData['message'];
        Get.snackbar(
          'Error',
          'Error uploading image: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal upload foto $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  Future<File> compressImage(File file) async {
    final Uint8List imageBytes = await file.readAsBytes();
    final ui.Codec codec =
        await ui.instantiateImageCodec(imageBytes, targetWidth: 600);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List compressedBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_image.png');
    await tempFile.writeAsBytes(compressedBytes);

    return tempFile;
  }

  Future<bool> uploadImageChildren({
    required String usertypeID,
    required String username,
    required String imagePath,
  }) async {
    final LoginController _loginController = Get.put(LoginController());
    try {
      final url = Uri.parse(
          'https://sch.sindigilive.com/api/v10/profile/photoupload/$usertypeID/$username');
      final token = await _loginController.getToken();

      var request = new http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
        File compressedImage = await compressImage(File(imagePath));

        var file = await http.MultipartFile.fromPath(
          'photo',
          compressedImage.path,
          contentType: MediaType.parse(
              'image/${getFileExtension(compressedImage.path)}'),
        );
        request.files.add(file);
      } else {
        Get.snackbar(
          'Error',
          'Gagal upload foto',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // refreshProfile();
        return true;
      } else {
        final responseData = jsonDecode(response.body);
        errorMessage = responseData['message'];
        Get.snackbar(
          'Error',
          'Error uploading image: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal upload foto $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  String getFileExtension(String filename) {
    return filename.split('.').last;
  }

  @override
  void onClose() {
    fatherController.dispose();
    fatherJobController.dispose();
    motherController.dispose();
    motherJobController.dispose();
    addressController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void refreshProfile() {
    profiles.clear();
    childrens.clear();
    fetchProfile();
  }
}
