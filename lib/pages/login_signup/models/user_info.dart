import 'package:flutter/foundation.dart';

class UserInfo {
  static const String role = "USER";
  final String userId;
  final String lastLoginTime;
  String name;
  String email;
  String phoneNo;
  String password;
  String courseId;
  String city;

  UserInfo({
    this.userId,
    @required this.name,
    @required this.email,
    @required this.phoneNo,
    this.password,
    this.courseId,
    this.city,
    this.lastLoginTime,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        userId: json['userId'] ?? "",
        name: json['fullName'] ?? "",
        email: json['email'] ?? "",
        phoneNo: json['phoneNo'] ?? "",
        city: json['city'] ?? "",
        courseId: json['courseId'] ?? "",
        lastLoginTime: json['lastLoginTime'] ?? ""
    );
  }

  Map<String, String> toJson() {
    final data = new Map<String, String>();
    data['role'] = UserInfo.role;
    data['userId'] = this.userId;
    data['fullName'] = this.name;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['password'] = this.password;
    data['city'] = this.city;
    data['courseId'] = this.courseId;
    return data;
  }
}
