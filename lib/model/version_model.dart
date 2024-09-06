// To parse this JSON data, do
//
//     final version = versionFromJson(jsonString);

import 'dart:convert';

Version versionFromJson(String str) => Version.fromJson(json.decode(str));

String versionToJson(Version data) => json.encode(data.toJson());

class Version {
  bool status;
  String message;
  Data data;

  Version({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(
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
  Settings settings;

  Data({
    required this.settings,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        settings: Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "settings": settings.toJson(),
      };
}

class Settings {
  String absentAutoSms;
  String address;
  String attendance;
  String attendanceNotification;
  String attendanceNotificationTemplate;
  String attendanceSmsgateway;
  String automation;
  String autoInvoiceGenerate;
  String autoUpdateNotification;
  String backendTheme;
  String captchaStatus;
  String currencyCode;
  String currencySymbol;
  String email;
  String exClass;
  String footer;
  String frontendorbackend;
  String frontendTheme;
  String googleAnalytics;
  String language;
  String languageStatus;
  String marktypeId;
  String mark1;
  String note;
  String phone;
  String photo;
  String profileEdit;
  String purchaseCode;
  String purchaseUsername;
  String recaptchaSecretKey;
  String recaptchaSiteKey;
  String schoolType;
  String schoolYear;
  String sname;
  String studentIdFormat;
  String timestart;
  String timeZone;
  String updateversion;
  String weekends;

  Settings({
    required this.absentAutoSms,
    required this.address,
    required this.attendance,
    required this.attendanceNotification,
    required this.attendanceNotificationTemplate,
    required this.attendanceSmsgateway,
    required this.automation,
    required this.autoInvoiceGenerate,
    required this.autoUpdateNotification,
    required this.backendTheme,
    required this.captchaStatus,
    required this.currencyCode,
    required this.currencySymbol,
    required this.email,
    required this.exClass,
    required this.footer,
    required this.frontendorbackend,
    required this.frontendTheme,
    required this.googleAnalytics,
    required this.language,
    required this.languageStatus,
    required this.marktypeId,
    required this.mark1,
    required this.note,
    required this.phone,
    required this.photo,
    required this.profileEdit,
    required this.purchaseCode,
    required this.purchaseUsername,
    required this.recaptchaSecretKey,
    required this.recaptchaSiteKey,
    required this.schoolType,
    required this.schoolYear,
    required this.sname,
    required this.studentIdFormat,
    required this.timestart,
    required this.timeZone,
    required this.updateversion,
    required this.weekends,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        absentAutoSms: json["absent_auto_sms"],
        address: json["address"],
        attendance: json["attendance"],
        attendanceNotification: json["attendance_notification"],
        attendanceNotificationTemplate:
            json["attendance_notification_template"],
        attendanceSmsgateway: json["attendance_smsgateway"],
        automation: json["automation"],
        autoInvoiceGenerate: json["auto_invoice_generate"],
        autoUpdateNotification: json["auto_update_notification"],
        backendTheme: json["backend_theme"],
        captchaStatus: json["captcha_status"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
        email: json["email"],
        exClass: json["ex_class"],
        footer: json["footer"],
        frontendorbackend: json["frontendorbackend"],
        frontendTheme: json["frontend_theme"],
        googleAnalytics: json["google_analytics"],
        language: json["language"],
        languageStatus: json["language_status"],
        marktypeId: json["marktypeID"],
        mark1: json["mark_1"],
        note: json["note"],
        phone: json["phone"],
        photo: json["photo"],
        profileEdit: json["profile_edit"],
        purchaseCode: json["purchase_code"],
        purchaseUsername: json["purchase_username"],
        recaptchaSecretKey: json["recaptcha_secret_key"],
        recaptchaSiteKey: json["recaptcha_site_key"],
        schoolType: json["school_type"],
        schoolYear: json["school_year"],
        sname: json["sname"],
        studentIdFormat: json["student_ID_format"],
        timestart: json["timestart"],
        timeZone: json["time_zone"],
        updateversion: json["updateversion"],
        weekends: json["weekends"],
      );

  Map<String, dynamic> toJson() => {
        "absent_auto_sms": absentAutoSms,
        "address": address,
        "attendance": attendance,
        "attendance_notification": attendanceNotification,
        "attendance_notification_template": attendanceNotificationTemplate,
        "attendance_smsgateway": attendanceSmsgateway,
        "automation": automation,
        "auto_invoice_generate": autoInvoiceGenerate,
        "auto_update_notification": autoUpdateNotification,
        "backend_theme": backendTheme,
        "captcha_status": captchaStatus,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
        "email": email,
        "ex_class": exClass,
        "footer": footer,
        "frontendorbackend": frontendorbackend,
        "frontend_theme": frontendTheme,
        "google_analytics": googleAnalytics,
        "language": language,
        "language_status": languageStatus,
        "marktypeID": marktypeId,
        "mark_1": mark1,
        "note": note,
        "phone": phone,
        "photo": photo,
        "profile_edit": profileEdit,
        "purchase_code": purchaseCode,
        "purchase_username": purchaseUsername,
        "recaptcha_secret_key": recaptchaSecretKey,
        "recaptcha_site_key": recaptchaSiteKey,
        "school_type": schoolType,
        "school_year": schoolYear,
        "sname": sname,
        "student_ID_format": studentIdFormat,
        "timestart": timestart,
        "time_zone": timeZone,
        "updateversion": updateversion,
        "weekends": weekends,
      };
}
