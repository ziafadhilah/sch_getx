// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/absence_controller.dart';
import 'package:sch/model/absence_model.dart';
import 'package:intl/intl.dart';
import 'package:calendar_appbar/calendar_appbar.dart';

class AbsenceHistoryPage extends StatefulWidget {
  const AbsenceHistoryPage({super.key});

  @override
  State<AbsenceHistoryPage> createState() => _AbsenceHistoryPageState();
}

class _AbsenceHistoryPageState extends State<AbsenceHistoryPage> {
  final AbsenceController _absenceController = Get.put(AbsenceController());
  String imageUrl = 'https://smpn1sumber-153.com/uploads/images';
  late DateTime selectedDate;
  final DateTime lastDate = DateTime.now();

  final args = Get.arguments;

  @override
  void initState() {
    super.initState();
    selectedDate = args['selectedDate'];
  }

  Widget _buildFilteredData() {
    if (args != null && args is Map<String, dynamic>) {
      final String srstudentId = args['srstudentId'];
      return GetBuilder<AbsenceController>(
        init: AbsenceController(),
        builder: (controller) {
          List<Attendance> filteredAttendance = controller.attendance
              .where(
                (attendance) =>
                    attendance.studentId == srstudentId &&
                    DateTime(attendance.datetime.year,
                            attendance.datetime.month, attendance.datetime.day)
                        .isAtSameMomentAs(
                      DateTime(selectedDate.year, selectedDate.month,
                          selectedDate.day),
                    ),
              )
              .toList();
          return filteredAttendance.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredAttendance.length,
                  itemBuilder: (context, index) {
                    Attendance attendance = filteredAttendance[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    '$imageUrl/${attendance.photo}',
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        attendance.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (attendance.timein != null)
                                        Text(
                                          'Waktu Masuk: ${attendance.timein}',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      if (attendance.timeout != null)
                                        Text(
                                          'Waktu Pulang: ${attendance.timeout}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      Text(
                                        DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(
                                            attendance.datetime.toString(),
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Column(
                  children: [
                    Image.asset(
                      'assets/images/no_data.png',
                      width: 135,
                      height: 135,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Tidak ada data absen pada tanggal ini',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _buildHistoryData() {
    if (args != null && args is Map<String, dynamic>) {
      final String srstudentId = args['srstudentId'];
      return Obx(
        () => _absenceController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _absenceController.attendance.length,
                itemBuilder: (context, index) {
                  final Attendance attendance =
                      _absenceController.attendance[index];
                  if (attendance.studentId != srstudentId) {
                    return SizedBox.shrink();
                  }
                  final String datetime = attendance.datetime.toString();
                  final formattedDatetime = datetime != '-'
                      ? DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(datetime))
                      : '-';
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                attendance.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 80,
                                  child: Text(formattedDatetime),
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Absen Masuk',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Absen Pulang',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(attendance.timein ?? '-'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(attendance.timeout ?? '-')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      appBar: CalendarAppBar(
        white: Colors.white,
        black: Color(0xff00A2B9),
        accent: Color(0xff00A2B9),
        locale: 'id',
        firstDate: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
        lastDate: lastDate,
        onDateChanged: (date) {
          setState(() {
            selectedDate = date;
            // filterAttendanceData(selectedDate);
          });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Data Absen',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff5B616E),
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildFilteredData(),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(left: 12.0, top: 10),
              alignment: Alignment.topLeft,
              child: Text(
                'Riwayat Absensi Siswa',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff5B616E),
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildHistoryData(),
          ],
        ),
      ),
    );
  }
}
