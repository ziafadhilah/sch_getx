// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/login_controller.dart';
import 'package:sch/controllers/version_controller.dart';
import 'package:sch/layouts/menu_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _rememberMe = false;
  final LoginController _loginController = LoginController();
  final VersionController _versionController = Get.put(VersionController());
  String imageUrl = 'https://sch.sindigilive.com/uploads/images';

  @override
  void initState() {
    super.initState();
    _versionController.fetchVersion();
  }

  void _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username dan password harus diisi');
      return;
    }

    try {
      await _loginController.loginUser(username, password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      if (token != null) {
        if (_rememberMe) {
          prefs.setBool('remember_me', true);
        }
        Get.offAll(Dashboard());
      } else {
        Get.snackbar('Error', 'Gagal login');
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  Widget _buildText() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vector/vector_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Obx(() {
                if (_versionController.isLoading.value) {
                  return CircularProgressIndicator();
                } else {
                  final settings = _versionController.settings.first;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        '$imageUrl/${settings.photo}',
                        width: 120,
                      ),
                      SizedBox(height: 10),
                      Text(
                        settings.sname,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00A2B9),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color(0xFF00A2B9),
                              width: 1,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Username',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color(0xFF00A2B9),
                              width: 1,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 2),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    color: Color(0xFF00A2B9),
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CupertinoSwitch(
                                    activeColor: Color(0xFF00A2B9),
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Ingat Saya',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF00A2B9)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Obx(() {
            if (_versionController.isLoading.value) {
              return Container();
            } else {
              final settings = _versionController.settings.first;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Absensi Mobile Versi ${settings.updateversion} © ${DateTime.now().year}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: _buildText(),
        ),
      ),
    );
  }
}
