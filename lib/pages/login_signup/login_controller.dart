import 'dart:convert';
import 'dart:developer';

import 'package:drops_app/common/services/http_service.dart';
import 'package:drops_app/common/services/shared_pref.dart';

import 'models/login_data.dart';
import 'models/user_info.dart';

class LoginController {
  static final _sharedPref = SharedPref.instance;
  final _httpService = HttpService();
  UserInfo currentUser;

  Future<String> loginWithPassword({LoginData loginData}) async {
    const endPointUrl = "ecom/user/signin";
    final parameters = loginData.toJson();

    String errorMessage = await _httpRequest(endPointUrl, parameters);
    return errorMessage;
  }

  Future<String> signup({UserInfo userInfo}) async {
    const endPointUrl = "ecom/user/user/signup";
    final parameters = userInfo.toJson();

    currentUser = userInfo;
    String errorMessage = await _httpRequest(endPointUrl, parameters);
    return errorMessage;
  }

  Future<String> forgotPassword({String email}) async {
    const endPointUrl = "ecom/user/forgotPassword";
    final Map<String, String> parameters = {"email": email};

    try {
      await _httpService.get(endPointUrl, parameters);
      return null;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  Future logout() async {
    _sharedPref.removeIsLoggedIn();
    _sharedPref.removeAuthToken();
    _sharedPref.removeUser();
  }

  Future<bool> isUserAuthorized() async {
    return await SharedPref.instance.readIsLoggedIn();
  }

  Future<String> _httpRequest(
    String url,
    Map<String, String> parameters, {
    String token,
    bool isPost = true,
  }) async {
    try {
      var response;
      if (isPost) {
        response = await _httpService.post(
          url,
          parameters,
          fireBaseAccessToken: token,
        );
      } else {
        response = await _httpService.get(
          url,
          parameters,
          fireBaseAccessToken: token,
        );
      }

      return saveUser(response);
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  String saveUser(response) {
    String authToken = response['userId'];
    if (authToken == null) {
      // Signup
      authToken = response['message'];
      response = currentUser.toJson();
      response['userId'] = authToken;
    }

    var loginResponse = UserInfo.fromJson(response);
    if (loginResponse != null && response['role'] == UserInfo.role) {
      _sharedPref.saveIsLoggedIn(true);
      _sharedPref.saveUserAuthToken(authToken);
      _sharedPref.saveUser(json.encode(response));
      return null;
    } else {
      return "Invalid Username and Password";
    }
  }
}
