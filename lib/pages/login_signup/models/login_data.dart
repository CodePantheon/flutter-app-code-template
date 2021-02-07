import 'package:flutter/foundation.dart';

class LoginData {
  final String email;
  final String phoneNumber;
  final String password;

  const LoginData({
    @required this.email,
    @required this.phoneNumber,
    @required this.password,
  });

  Map<String, String> toJson(){
    final data = new Map<String, String>();
    data['userEmail'] = this.email;
    data['userPhoneNo'] = this.phoneNumber;
    data['password'] = this.password;
    return data;
  }
}
