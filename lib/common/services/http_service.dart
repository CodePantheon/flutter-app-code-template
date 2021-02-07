import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_configuration.dart';
import 'error_response.dart';
import 'custom_exceptions.dart';
import 'shared_pref.dart';

enum HttpRequest { GET, POST }

class HttpService {
  static final _appBaseUrl = ApiConfiguration.serverBaseUrl;
  static final _jsonHeader = {
    HttpHeaders.contentTypeHeader: "application/json",
    'access_token': null,
    'API-SIGNING-AUTH': null,
    "version": null,
  };

  Future<dynamic> get(
    String endPointUrl,
    Map<String, String> parameters, {
    String baseUrl,
    String fireBaseAccessToken,
    bool isSecured = ApiConfiguration.IS_SECURED,
  }) async {
    return await _request(
      baseUrl,
      endPointUrl,
      parameters,
      HttpRequest.GET,
      fireBaseAccessToken: fireBaseAccessToken,
      isSecured: isSecured,
    );
  }

  Future<dynamic> post(
    String endPointUrl,
    Map<String, String> parameters, {
    String paramData = '',
    String baseUrl,
    String fireBaseAccessToken,
    bool isSecured = ApiConfiguration.IS_SECURED,
  }) async {
    return await _request(
      baseUrl,
      endPointUrl,
      parameters,
      HttpRequest.POST,
      paramData: paramData,
      fireBaseAccessToken: fireBaseAccessToken,
      isSecured: isSecured,
    );
  }

  Future<dynamic> _request(
    String baseUrl,
    String endPointUrl,
    Map<String, String> parameters,
    HttpRequest requestType, {
    String paramData = '',
    String fireBaseAccessToken,
    bool isSecured,
  }) async {
    baseUrl = baseUrl ?? _appBaseUrl;

    parameters = parameters ?? Map<String, String>();
    parameters['version'] = ApiConfiguration.APP_VERSION;

    try {
      Uri uri;
      if (isSecured == false) {
        uri = parameters == null
            ? Uri.http(baseUrl, endPointUrl)
            : Uri.http(baseUrl, endPointUrl, parameters);
      } else {
        uri = parameters == null
            ? Uri.https(baseUrl, endPointUrl)
            : Uri.https(baseUrl, endPointUrl, parameters);
      }

      log("URI: " + uri.toString());
      _jsonHeader['X-AUTH-TOKEN'] = await SharedPref.instance.getAuthToken();
      _jsonHeader['API-SIGNIN-AUTH'] = fireBaseAccessToken;

      var response;
      if (paramData != '') {
        response = await http.post(uri, body: paramData, headers: _jsonHeader);
      } else {
        response = requestType == HttpRequest.GET
            ? await http.get(uri, headers: _jsonHeader)
            : await http.post(uri, headers: _jsonHeader);
      }

      return _decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  _decodeResponse(http.Response response) {
    log(response.body.toString());

    var responseJson = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.OK:
        return responseJson;
      case HttpStatus.NOT_FOUND:
      case HttpStatus.UNAUTHORIZED:
      case HttpStatus.FORBIDDEN:
      case HttpStatus.CONFLICT:
        var errorMessage = ErrorResponse.fromJson(responseJson).message;
        throw ServerException(errorMessage);
      case HttpStatus.INTERNAL_SERVER_ERROR:
      default:
        throw FetchDataException(
          'Something went wrong. Please try again. ERROR -'
          '${response.statusCode}',
        );
    }
  }
}

class HttpStatus {
  static const int OK = 200;
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int CONFLICT = 409;
  static const int INTERNAL_SERVER_ERROR = 500;
}
