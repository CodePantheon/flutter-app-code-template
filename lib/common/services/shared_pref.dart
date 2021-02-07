import 'dart:convert';

import 'package:drops_app/pages/login_signup/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _isLoggedInKey = "isStudentLoggedIn";
  static const String _authTokenKey = "studentAuthToken";
  static const String _userInfo = "studentUserInfo";
  static final SharedPref instance = SharedPref._instantiate();

  SharedPref._instantiate();

  readIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_isLoggedInKey) == null)
      return false;
    else
      return prefs.getBool(_isLoggedInKey);
  }

  saveIsLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedInKey, value);
  }

  Future<bool> removeIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_isLoggedInKey);
  }

  Future<String> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  saveUserAuthToken(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, value);
  }

  Future<bool> removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_authTokenKey);
  }

  Future<UserInfo> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString(_userInfo) != null) {
      Map<String, dynamic> map = json.decode(prefs.getString(_userInfo));
      return UserInfo.fromJson(map);
    }else{
      return UserInfo(name: "User", email: "", phoneNo: "");
    }
  }

  saveUser(userInfoJson) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userInfo, userInfoJson);
  }

  Future<bool> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_userInfo);
  }

  Future<bool> getIsSubmitted(testId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(testId) ?? false;
  }

  saveIsSubmitted(testId, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(testId, value);
  }

  Future<bool> removeIsSubmitted(testId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_userInfo);
  }
}
