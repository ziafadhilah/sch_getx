// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/login_controller.dart';
import 'package:sch/controllers/profile_controller.dart';
import 'package:sch/model/profile_model.dart';
import 'package:sch/view/profile/detail_profile_children.dart';
import 'package:sch/view/profile/edit_photo_parents.dart';
import 'package:sch/view/profile/forget.dart';
import 'package:sch/view/profile/version.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = Get.put(ProfileController());
  final LoginController _loginController = LoginController();
  String imageUrl = 'https://smpn1sumber-153.com/uploads/images';

  @override
  void initState() {
    super.initState();
    // _profileController.refreshProfile();
  }

  void _showImageOptionsDialog(ProfileItem profile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilihan Foto Profil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showProfileImageDialog(profile);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Text("Lihat Foto"),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(EditPhotoPageParent(), arguments: profile);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Text("Edit"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProfileImageDialog(ProfileItem profile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: profile.photo.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      ('$imageUrl/${profile.photo}'),
                      height: 280,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void _editProfileParents(ProfileItem profile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text("Edit Profil Orang Tua"),
          content: Container(
            width: MediaQuery.of(context).size.width - 80,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _profileController.addressController,
                    decoration: InputDecoration(labelText: 'Alamat'),
                  ),
                  TextField(
                    controller: _profileController.fatherController,
                    decoration: InputDecoration(labelText: 'Nama Ayah'),
                  ),
                  TextField(
                    controller: _profileController.fatherJobController,
                    decoration: InputDecoration(labelText: 'Pekerjaan Ayah'),
                  ),
                  TextField(
                    controller: _profileController.motherController,
                    decoration: InputDecoration(labelText: 'Nama Ibu'),
                  ),
                  TextField(
                    controller: _profileController.motherJobController,
                    decoration: InputDecoration(labelText: 'Pekerjaan Ibu'),
                  ),
                  TextField(
                    controller: _profileController.nameController,
                    decoration: InputDecoration(labelText: 'Nama Wali'),
                  ),
                  TextField(
                    controller: _profileController.emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _profileController.phoneController,
                    decoration: InputDecoration(labelText: 'No. Telepon'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _profileController.refreshProfile();
                          Navigator.pop(context);
                        },
                        child: Text('Batal'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _profileController.saveProfileData();
                          Navigator.pop(context);
                        },
                        child: Text('Simpan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showProfileParentsDetail(ProfileItem profile) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Data Pribadi Orang Tua',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Alamat'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.address),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('No. Telp'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.phone),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Nama Ayah'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.fatherName),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Pekerjaan Ayah'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.fatherProfession),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Nama Ibu'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.motherName),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Pekerjaan Ibu'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.motherProfession),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Nama Wali'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.name),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xff3F3D5633),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Email'),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(profile.email),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            )),
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

  void _showProfileChildrenDetail(BuildContext context) {
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

  Widget _buildCard(ProfileItem profile) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            bottom: 15,
          ),
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/education_bg.png'),
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _showImageOptionsDialog(profile);
                  },
                  child: profile.photo.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            ('$imageUrl/${profile.photo}'),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CircularProgressIndicator(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        profile.createUsertype ?? '-',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    // color: Color(0xFF00A2B9),
                  ),
                  child: InkWell(
                    onTap: () {
                      _editProfileParents(profile);
                    },
                    child: Icon(Icons.edit_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Text(
        'Keamanan dan Privasi',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildProfileParents(ProfileItem profile) {
    return InkWell(
      onTap: () {
        _showProfileParentsDetail(profile);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 30,
              child: Image.asset(
                'assets/icon/profile1_ico.png',
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                'Profile Orang Tua',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStudents(Children children) {
    return InkWell(
      onTap: () {
        _showProfileChildrenDetail(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 30,
              child: Image.asset(
                'assets/icon/profile2_ico.png',
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                'Profile Siswa',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _profileController.childrens.length,
      itemBuilder: (BuildContext context, int index) {
        final Children child = _profileController.childrens[index];
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
                        '$imageUrl/${child.photo}',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

  Widget _buildChangePassword(ProfileItem profile) {
    return InkWell(
      onTap: () {
        Get.to(
          ForgetPassword(),
          arguments: profile,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 30,
              child: Image.asset(
                'assets/icon/change_password_ico.png',
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                'Ganti Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAboutApp() {
    return InkWell(
      onTap: () {
        Get.to(VersionPage());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 30,
              child: Image.asset(
                'assets/icon/info_ico.png',
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                'Tentang Aplikasi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Konfirmasi Logout"),
                    content: Text("Apakah Anda yakin ingin logout?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await _loginController.logoutUser();
                          Get.offAllNamed('/login');
                        },
                        child: Text("Ya"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Tutup dialog
                        },
                        child: Text("Tidak"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () {
                if (_profileController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final profiles = _profileController.profiles;
                  if (profiles.isNotEmpty) {
                    final mainProfile = profiles[0];
                    return _buildCard(mainProfile);
                  } else {
                    return SizedBox();
                  }
                }
              },
            ),
            _buildText(),
            Obx(
              () {
                if (_profileController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final profiles = _profileController.profiles;
                  if (profiles.isNotEmpty) {
                    final mainProfile = profiles[0];
                    return _buildProfileParents(mainProfile);
                  } else {
                    return SizedBox();
                  }
                }
              },
            ),
            Obx(
              () {
                if (_profileController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final children = _profileController.childrens;
                  if (children.isNotEmpty) {
                    final mainProfile = children[0];
                    return _buildProfileStudents(mainProfile);
                  } else {
                    return SizedBox();
                  }
                }
              },
            ),
            Obx(
              () {
                if (_profileController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final profiles = _profileController.profiles;
                  if (profiles.isNotEmpty) {
                    final mainProfile = profiles[0];
                    return _buildChangePassword(mainProfile);
                  } else {
                    return SizedBox();
                  }
                }
              },
            ),
            _buildAboutApp(),
          ],
        ),
      ),
    );
  }
}
