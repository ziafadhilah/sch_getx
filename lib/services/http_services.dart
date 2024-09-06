// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'package:http/http.dart' as http;

const urlBase = 'https://sch.sindigilive.com/api/v10';
// const urlBase = 'https://smpn1sumber-153.com/api/v10';

class Request {
  late final String url;
  late final dynamic body;

  Request({required this.url, this.body});

  Future<http.Response> get() {
    // print(urlBase + url);
    return http.get(Uri.parse(urlBase + url)).timeout(Duration(minutes: 2));
  }

  Future<http.Response> post() {
    return http
        .post(Uri.parse(urlBase + url), body: body)
        .timeout(Duration(minutes: 2));
  }

  Future<http.Response> postChange({dynamic body}) {
    return http
        .post(Uri.parse(urlBase + url), body: body)
        .timeout(Duration(minutes: 2));
  }

  Future<http.Response> patch(String? token, {dynamic body}) {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return http.put(Uri.parse(urlBase + url), headers: headers, body: body);
  }

  Future<http.Response> postWithToken(String token) {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return http
        .post(Uri.parse(urlBase + url), headers: headers, body: body)
        .timeout(Duration(minutes: 2));
  }

  // Future<http.Response> delete() {
  //   return http
  //       .delete(Uri.parse(urlBase + url), body: body)
  //       .timeout(Duration(minutes: 2));
  // }

  Future<http.Response> getWithToken(String? token) {
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    // print(urlBase + url);
    return http
        .get(Uri.parse(urlBase + url), headers: headers)
        .timeout(Duration(minutes: 2));
  }
}
