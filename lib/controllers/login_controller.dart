import 'dart:convert';
import 'package:get/get.dart';
import 'package:sch/services/http_services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  Future<void> loginUser(String username, String password) async {
    final url = '/signin';
    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      final response = await Request(url: url, body: body).post();
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = data['data']['token'];
        prefs.setString('auth_token', token);
        Get.snackbar('Alert', 'Login Sukses', snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar('Alert', 'Login Gagal, User atau Password salah.',
            snackPosition: SnackPosition.TOP);
        throw Exception('Gagal Login');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    try {
      await Request(url: '/signin/signout').postWithToken(token!);
      prefs.remove('auth_token');
      Get.snackbar('Alert', 'Logout Sukses', snackPosition: SnackPosition.TOP);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
