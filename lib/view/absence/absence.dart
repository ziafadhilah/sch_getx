// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/absence_controller.dart';
import 'package:sch/controllers/profile_controller.dart';
import 'package:sch/model/profile_model.dart';
import 'package:sch/view/absence/absence_history.dart';

class AbsencePage extends StatefulWidget {
  const AbsencePage({super.key});

  @override
  State<AbsencePage> createState() => _AbsencePageState();
}

class _AbsencePageState extends State<AbsencePage> {
  final ProfileController _profileController = Get.put(ProfileController());
  final AbsenceController _absenceController = Get.put(AbsenceController());

  String imageUrl = 'https://smpn1sumber-153.com/uploads/images';

  @override
  void initState() {
    super.initState();
    // _profileController.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Absensi'),
        elevation: 8,
        shadowColor: Colors.black,
        toolbarHeight: 70,
        // leading: IconButton(
        //   iconSize: 35,
        //   icon: Icon(Icons.chevron_left),
        //   onPressed: () {},
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => _profileController.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _profileController.childrens.length,
                      itemBuilder: (context, index) {
                        final Children child =
                            _profileController.childrens[index];
                        return InkWell(
                          onTap: () {
                            DateTime lastDate =
                                _absenceController.getLastAttendanceDate();
                            Get.to(
                              AbsenceHistoryPage(),
                              arguments: {
                                'srstudentId': child.srstudentId,
                                'selectedDate': lastDate,
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: 20,
                                ),
                                height: 110,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/education_bg.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: ClipOval(
                                          child: Image.network(
                                            Uri.parse(
                                                    '$imageUrl/${child.photo}')
                                                .toString(),
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nama Siswa',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.2,
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
                                              'Kelas ${child.srclasses} - ${child.srsection}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text('')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
