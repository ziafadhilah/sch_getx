// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sch/controllers/profile_controller.dart';
import 'package:sch/model/profile_model.dart';

class EditPhotoPageChildren extends StatefulWidget {
  const EditPhotoPageChildren({super.key});

  @override
  State<EditPhotoPageChildren> createState() => _EditPhotoPageChildrenState();
}

class _EditPhotoPageChildrenState extends State<EditPhotoPageChildren> {
  final Children children = Get.arguments as Children;
  final String imageUrl = 'https://smpn1sumber-153.com/uploads/images';
  late String _imageUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageUrl = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _imageUrl = '$imageUrl/${children.photo}';
  }

  Future<void> _saveImageToServer() async {
    if (_imageUrl.isNotEmpty) {
      final ProfileController _profileController =
          Get.find<ProfileController>();
      final String usertypeID = children.usertypeId.toString();
      final String username = children.username.toString();

      final bool success = await _profileController.uploadImageChildren(
        usertypeID: usertypeID,
        username: username,
        imagePath: _imageUrl,
      );

      if (success) {
        setState(() {
          Get.back();
          _imageUrl = '$imageUrl/${children.photo}';
          _showSuccessSnackbar();
          _profileController.refreshProfile();
        });
      } else {
        final String? errorMessage = _profileController.errorMessage;
        _showErrorSnackbar(errorMessage ?? 'An error occurred');
      }
    } else {
      _showErrorSnackbar('Invalid image path');
    }
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil diperbarui.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      appBar: AppBar(
        title: Text(
          'Edit Foto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1C6B7F),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          iconSize: 35,
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/vector/vector_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xff1C6B7F).withOpacity(0.6),
                border: Border.all(
                  width: 0.2,
                  color: Color(0xffF5F6FB),
                ),
              ),
              width: 200,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: _imageUrl.isNotEmpty
                    ? _imageUrl.startsWith('http')
                        ? ClipOval(
                            child: Image.network(
                              _imageUrl,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                              File(_imageUrl),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          )
                    : Container(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Divider(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Action',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff5B616E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 0.1,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 5, left: 12),
                          child: Icon(
                            Icons.photo_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Pilih Dari Galeri',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 0.1,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 5, left: 12),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Buka Kamera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 0.1,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      _saveImageToServer();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 5, left: 12),
                          child: Icon(
                            Icons.save_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 0.1,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 5, left: 12),
                          child: Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Batal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
