// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sch/controllers/profile_controller.dart';
import 'package:sch/model/profile_model.dart';
import 'package:intl/intl.dart';
import 'package:sch/view/profile/edit_photo_children.dart';

class DetailProfileChildrenPage extends StatefulWidget {
  final Children children;
  const DetailProfileChildrenPage({Key? key, required this.children})
      : super(key: key);

  @override
  State<DetailProfileChildrenPage> createState() =>
      _DetailProfileChildrenPageState();
}

class _DetailProfileChildrenPageState extends State<DetailProfileChildrenPage> {
  final String imageUrl = 'https://smpn1sumber-153.com/uploads/images';
  final ProfileController _profileController = Get.put(ProfileController());

  late TextEditingController childDobController;

  @override
  void initState() {
    super.initState();
    childDobController = TextEditingController(
      text: DateFormat('dd MMMM yyyy').format(widget.children.dob),
    );
  }

  void updateProfilePhoto(String newPhotoUrl) {
    setState(() {
      widget.children.photo = newPhotoUrl;
    });
  }

  void _showProfileImageDialog(Children child) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: child.photo.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      ('$imageUrl/${child.photo}'),
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

  void _showImageOptionsDialog(Children child) {
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
                  _showProfileImageDialog(child);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Text("Lihat Foto"),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  String? newPhotoUrl =
                      await Get.to(EditPhotoPageChildren(), arguments: child);
                  if (newPhotoUrl != null) {
                    updateProfilePhoto(newPhotoUrl);
                  }
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

  void _showEditDialog(BuildContext context) {
    DateTime initialDOB = widget.children.dob;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text('Edit Data Siswa'),
          content: Container(
            width: MediaQuery.of(context).size.width - 80,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nama Siswa'),
                    initialValue: widget.children.name,
                    onChanged: (newValue) {
                      widget.children.name = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Alamat'),
                    initialValue: widget.children.address,
                    onChanged: (newValue) {
                      widget.children.address = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'No. Telp'),
                    initialValue: widget.children.phone,
                    onChanged: (newValue) {
                      widget.children.phone = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tempat Lahir'),
                    initialValue: widget.children.pob,
                    onChanged: (newValue) {
                      widget.children.pob = newValue;
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: initialDOB,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          initialDOB = pickedDate;
                          widget.children.dob = pickedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                        ),
                        controller: childDobController,
                        readOnly: true,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: widget.children.sex,
                    decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                    onChanged: (newValue) {
                      setState(() {
                        widget.children.sex = newValue ?? '';
                      });
                    },
                    items: <String>['Laki-laki', 'Perempuan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField<String>(
                    value: widget.children.bloodgroup,
                    decoration: InputDecoration(labelText: 'Gol. Darah'),
                    onChanged: (newValue) {
                      setState(() {
                        widget.children.bloodgroup = newValue ?? '';
                      });
                    },
                    items: <String>[
                      '-',
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'O+',
                      'O-',
                      'AB+',
                      'AB-'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField<String>(
                    value: widget.children.religion,
                    decoration: InputDecoration(labelText: 'Agama'),
                    onChanged: (newValue) {
                      setState(() {
                        widget.children.religion = newValue ?? '';
                      });
                    },
                    items: <String>[
                      'Islam',
                      'Kristen Protestan',
                      'Kristen Katolik',
                      'Hindu',
                      'Buddha',
                      'Khonghucu',
                      '',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Children editedChild = Children(
                  name: widget.children.name,
                  address: widget.children.address,
                  phone: widget.children.phone,
                  dob: widget.children.dob,
                  pob: widget.children.pob,
                  sex: widget.children.sex,
                  bloodgroup: widget.children.bloodgroup,
                  religion: widget.children.religion,
                  studentrelationId: widget.children.studentrelationId,
                  srstudentId: widget.children.srstudentId,
                  srname: widget.children.srname,
                  srclassesId: widget.children.srclassesId,
                  srclasses: widget.children.srclasses,
                  srroll: widget.children.srroll,
                  srregisterNo: widget.children.srregisterNo,
                  srsectionId: widget.children.srsectionId,
                  srsection: widget.children.srsection,
                  srstudentgroupId: widget.children.srstudentgroupId,
                  sroptionalsubjectId: widget.children.sroptionalsubjectId,
                  srschoolyearId: widget.children.srschoolyearId,
                  studentId: widget.children.studentId,
                  email: widget.children.email,
                  classesId: widget.children.classesId,
                  sectionId: widget.children.sectionId,
                  roll: widget.children.roll,
                  country: widget.children.country,
                  registerNo: widget.children.registerNo,
                  state: widget.children.state,
                  library: widget.children.library,
                  hostel: widget.children.hostel,
                  transport: widget.children.transport,
                  photo: widget.children.photo,
                  parentId: widget.children.parentId,
                  createschoolyearId: widget.children.createschoolyearId,
                  schoolyearId: widget.children.schoolyearId,
                  username: widget.children.username,
                  password: widget.children.password,
                  usertypeId: widget.children.usertypeId,
                  createDate: widget.children.createDate,
                  modifyDate: widget.children.modifyDate,
                  createUserId: widget.children.createUserId,
                  createUsername: widget.children.createUsername,
                  createUsertype: widget.children.createUsertype,
                  active: widget.children.active,
                  rfid: widget.children.rfid,
                );
                _profileController.saveChildrenData(editedChild);
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _profileController.refreshProfile();
                });
                Get.back();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1C6B7F),
        title: Text(
          'Detail Profile Anak',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            // _profileController.refreshProfile();
            Get.back();
          },
          icon: Icon(
            Icons.chevron_left,
          ),
          iconSize: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vector/vector_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _showImageOptionsDialog(widget.children);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: ClipOval(
                        child: widget.children.photo.isNotEmpty
                            ? Image.network(
                                '$imageUrl/${widget.children.photo}',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.children.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Siswa',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Data Siswa',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showEditDialog(context);
                      },
                      icon: Icon(Icons.edit_outlined),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5633),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Nama',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(widget.children.name),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5633),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Alamat',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(widget.children.address),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5633),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Kelas',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                                '${widget.children.srclasses} - ${widget.children.srsection}'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5633),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Tanggal Lahir',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              DateFormat('dd MMMM, yyyy')
                                  .format(widget.children.dob),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5633),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Jenis Kelamin',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(widget.children.sex),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5633),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'No Telepon',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(widget.children.phone),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5633),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Gol. Darah',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(widget.children.bloodgroup),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0xff3F3D5614),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Agama',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(':'),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(widget.children.religion),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
