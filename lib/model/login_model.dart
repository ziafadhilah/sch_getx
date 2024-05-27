// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  bool status;
  String message;
  Data data;

  Login({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String token;
  Profile profile;
  List<Child> children;

  Data({
    required this.token,
    required this.profile,
    required this.children,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        profile: Profile.fromJson(json["profile"]),
        children:
            List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "profile": profile.toJson(),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class Child {
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
  String? bloodgroup;
  String? country;
  String registerNo;
  String state;
  String childLibrary;
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
  String? rfid;
  List<Map<String, dynamic>> attendanceData;

  Child({
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
    this.bloodgroup,
    this.country,
    required this.registerNo,
    required this.state,
    required this.childLibrary,
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
    this.rfid,
    required this.attendanceData,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
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
        religion: json["religion"] ?? '-',
        email: json["email"] ?? '-',
        phone: json["phone"] ?? '-',
        address: json["address"],
        classesId: json["classesID"],
        sectionId: json["sectionID"],
        roll: json["roll"],
        bloodgroup: json["bloodgroup"] ?? '-',
        country: json["country"],
        registerNo: json["registerNO"],
        state: json["state"] ?? '',
        childLibrary: json["library"],
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
        attendanceData: List<Map<String, dynamic>>.from(
            json["attendanceData"].map((x) => Map<String, dynamic>.from(x)) ??
                '-'),
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
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
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
        "library": childLibrary,
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
        "attendanceData": List<dynamic>.from(attendanceData.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}

class Profile {
  String loginuserId;
  String name;
  String fatherName;
  String motherName;
  String fatherProfession;
  String motherProfession;
  String phone;
  String address;
  String email;
  String usertypeId;
  String usertype;
  String username;
  String password;
  String photo;
  String lang;
  String defaultschoolyearId;
  bool loggedin;
  bool varifyvaliduser;

  Profile({
    required this.loginuserId,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.fatherProfession,
    required this.motherProfession,
    required this.phone,
    required this.address,
    required this.email,
    required this.usertypeId,
    required this.usertype,
    required this.username,
    required this.password,
    required this.photo,
    required this.lang,
    required this.defaultschoolyearId,
    required this.loggedin,
    required this.varifyvaliduser,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        loginuserId: json["loginuserID"],
        name: json["name"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        fatherProfession: json["father_profession"],
        motherProfession: json["mother_profession"],
        phone: json["phone"],
        address: json["address"],
        email: json["email"],
        usertypeId: json["usertypeID"],
        usertype: json["usertype"],
        username: json["username"],
        password: json["password"],
        photo: json["photo"],
        lang: json["lang"],
        defaultschoolyearId: json["defaultschoolyearID"],
        loggedin: json["loggedin"],
        varifyvaliduser: json["varifyvaliduser"],
      );

  Map<String, dynamic> toJson() => {
        "loginuserID": loginuserId,
        "name": name,
        "father_name": fatherName,
        "mother_name": motherName,
        "father_profession": fatherProfession,
        "mother_profession": motherProfession,
        "phone": phone,
        "address": address,
        "email": email,
        "usertypeID": usertypeId,
        "usertype": usertype,
        "username": username,
        "password": password,
        "photo": photo,
        "lang": lang,
        "defaultschoolyearID": defaultschoolyearId,
        "loggedin": loggedin,
        "varifyvaliduser": varifyvaliduser,
      };
}
