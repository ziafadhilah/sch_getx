// ignore_for_file: unnecessary_this

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  ProfileData data;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        status: json["status"],
        message: json["message"],
        data: ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ProfileData {
  ProfileData({
    required this.profile,
    required this.childrens,
  });

  ProfileItem profile;
  List<Children> childrens;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        profile: ProfileItem.fromJson(json["profile"]),
        childrens: List<Children>.from(
            json["childrens"].map((x) => Children.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "childrens": List<dynamic>.from(childrens.map((x) => x.toJson())),
      };
}

class Children {
  Children({
    required this.studentrelationId,
    required this.srstudentId,
    required this.srname,
    required this.srclassesId,
    required this.srclasses,
    required this.srroll,
    required this.srregisterNo,
    required this.srsectionId,
    required this.srsection,
    required this.srstudentgroupId,
    required this.sroptionalsubjectId,
    required this.srschoolyearId,
    required this.studentId,
    required this.name,
    required this.dob,
    required this.pob,
    required this.sex,
    required this.religion,
    required this.email,
    required this.phone,
    required this.address,
    required this.classesId,
    required this.sectionId,
    required this.roll,
    required this.bloodgroup,
    required this.country,
    required this.registerNo,
    required this.state,
    required this.library,
    required this.hostel,
    required this.transport,
    required this.photo,
    required this.parentId,
    required this.createschoolyearId,
    required this.schoolyearId,
    required this.username,
    required this.password,
    required this.usertypeId,
    required this.createDate,
    required this.modifyDate,
    required this.createUserId,
    required this.createUsername,
    required this.createUsertype,
    required this.active,
    required this.rfid,
  });

  String studentrelationId;
  String srstudentId;
  String srname;
  String srclassesId;
  String srclasses;
  String srroll;
  String srregisterNo;
  String srsectionId;
  String srsection;
  String srstudentgroupId;
  String sroptionalsubjectId;
  String srschoolyearId;
  String studentId;
  String name;
  DateTime dob;
  String pob;
  String sex;
  String religion;
  String email;
  String phone;
  String address;
  String classesId;
  String sectionId;
  String roll;
  String bloodgroup;
  String? country;
  String registerNo;
  String? state;
  String library;
  String hostel;
  String transport;
  String photo;
  String parentId;
  String createschoolyearId;
  String schoolyearId;
  String username;
  String password;
  String usertypeId;
  DateTime createDate;
  DateTime modifyDate;
  String createUserId;
  String createUsername;
  String createUsertype;
  String active;
  String rfid;

  factory Children.fromJson(Map<String, dynamic> json) => Children(
        studentrelationId: json["studentrelationID"],
        srstudentId: json["srstudentID"],
        srname: json["srname"],
        srclassesId: json["srclassesID"],
        srclasses: json["srclasses"],
        srroll: json["srroll"],
        srregisterNo: json["srregisterNO"],
        srsectionId: json["srsectionID"],
        srsection: json["srsection"],
        srstudentgroupId: json["srstudentgroupID"],
        sroptionalsubjectId: json["sroptionalsubjectID"],
        srschoolyearId: json["srschoolyearID"],
        studentId: json["studentID"],
        name: json["name"],
        dob: DateTime.parse(json["dob"]),
        pob: json["pob"],
        sex: json["sex"],
        religion: json["religion"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        classesId: json["classesID"],
        sectionId: json["sectionID"],
        roll: json["roll"],
        bloodgroup: json["bloodgroup"],
        country: json["country"],
        registerNo: json["registerNO"],
        state: json["state"],
        library: json["library"],
        hostel: json["hostel"],
        transport: json["transport"],
        photo: json["photo"],
        parentId: json["parentID"],
        createschoolyearId: json["createschoolyearID"],
        schoolyearId: json["schoolyearID"],
        username: json["username"],
        password: json["password"],
        usertypeId: json["usertypeID"],
        createDate: DateTime.parse(json["create_date"]),
        modifyDate: DateTime.parse(json["modify_date"]),
        createUserId: json["create_userID"],
        createUsername: json["create_username"],
        createUsertype: json["create_usertype"],
        active: json["active"],
        rfid: json["rfid"],
      );

  Map<String, dynamic> toJson() => {
        "studentrelationID": studentrelationId,
        "srstudentID": srstudentId,
        "srname": srname,
        "srclassesID": srclassesId,
        "srclasses": srclasses,
        "srroll": srroll,
        "srregisterNO": srregisterNo,
        "srsectionID": srsectionId,
        "srsection": srsection,
        "srstudentgroupID": srstudentgroupId,
        "sroptionalsubjectID": sroptionalsubjectId,
        "srschoolyearID": srschoolyearId,
        "studentID": studentId,
        "name": name,
        "dob": dob.toIso8601String(),
        "pob": pob,
        "sex": sex,
        "religion": religion,
        "email": email,
        "phone": phone,
        "address": address,
        "classesID": classesId,
        "sectionID": sectionId,
        "roll": roll,
        "bloodgroup": bloodgroup,
        "country": country,
        "registerNO": registerNo,
        "state": state,
        "library": library,
        "hostel": hostel,
        "transport": transport,
        "photo": photo,
        "parentID": parentId,
        "createschoolyearID": createschoolyearId,
        "schoolyearID": schoolyearId,
        "username": username,
        "password": password,
        "usertypeID": usertypeId,
        "create_date": createDate.toIso8601String(),
        "modify_date": modifyDate.toIso8601String(),
        "create_userID": createUserId,
        "create_username": createUsername,
        "create_usertype": createUsertype,
        "active": active,
        "rfid": rfid,
      };
}

class ProfileItem {
  ProfileItem({
    required this.parentsId,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.fatherProfession,
    required this.motherProfession,
    required this.email,
    required this.phone,
    required this.address,
    required this.photo,
    this.username,
    this.password,
    this.usertypeId,
    this.createDate,
    this.modifyDate,
    this.createUserId,
    this.createUsername,
    this.createUsertype,
    this.active,
  });

  String parentsId;
  String name;
  String fatherName;
  String motherName;
  String fatherProfession;
  String motherProfession;
  String email;
  String phone;
  String address;
  String photo;
  String? username;
  String? password;
  String? usertypeId;
  DateTime? createDate;
  DateTime? modifyDate;
  String? createUserId;
  String? createUsername;
  String? createUsertype;
  String? active;

  factory ProfileItem.fromJson(Map<String, dynamic> json) => ProfileItem(
        parentsId: json["parentsID"],
        name: json["name"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        fatherProfession: json["father_profession"],
        motherProfession: json["mother_profession"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        photo: json["photo"],
        username: json["username"],
        password: json["password"],
        usertypeId: json["usertypeID"],
        createDate: DateTime.parse(json["create_date"]),
        modifyDate: DateTime.parse(json["modify_date"]),
        createUserId: json["create_userID"],
        createUsername: json["create_username"],
        createUsertype: json["create_usertype"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "parentsID": parentsId,
        "name": name,
        "father_name": fatherName,
        "mother_name": motherName,
        "father_profession": fatherProfession,
        "mother_profession": motherProfession,
        "email": email,
        "phone": phone,
        "address": address,
        "photo": photo,
        "username": username,
        "password": password,
        "usertypeID": usertypeId,
        "create_date": createDate.toString(),
        "modify_date": modifyDate.toString(),
        "create_userID": createUserId,
        "create_username": createUsername,
        "create_usertype": createUsertype,
        "active": active,
      };
}
