
import 'dart:convert';

import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/data/model/error_json.dart';

import '../singleton/local_language.dart';

enum ServiceErrorType { Error, SocketException, TimeoutException }


class Service{
  String apiUrl(){
    return api_url;
  }

  Future<Map<String, String>> createHeaderUnAuthorization() async {
    Map<String, String> headers;

    headers = {'Content-type': 'application/json'};
    return headers;
  }

  Future<Map<String, String>> createHeaderAuthorization(
      {String? tokenAuthor}) async {
    var headersContentType = 'application/json';
    var langID =  LocalizationService().delegate.currentLocale.languageCode;
    var token = tokenAuthor ?? '';//await tokenPreferences.getPreferredToken();
    return {
      'Content-type': '$headersContentType',
      'LangID': '$langID',
      'Authorization': token,
    };
  }

  bool isResponseSuccess(int statusCode) {
    var result = false;
    if (statusCode == 200 ||
        statusCode == 201 ||
        statusCode == 202 ||
        statusCode == 203 ||
        statusCode == 204 ||
        statusCode == 205 ||
        statusCode == 206 ||
        statusCode == 207 ||
        statusCode == 208 ||
        statusCode == 226) result = true;
    return result;
  }

  bool isResponseErrorNetwork(int statusCode) {
    var result = false;
    if (statusCode == 500 ||
        statusCode == 404 ||
        statusCode == 301 ||
        statusCode == 302 ||
        statusCode == 303) result = true;
    return result;
  }

  static isHasJsonMessage(String message) {
    message = message.toLowerCase();
    return message.contains('message') || message.contains('messages');
  }

  dynamic responseBody(var response) {
    var error = response.body.toString();
    if (isHasJsonMessage(error) && response.statusCode != 200) {
      throw JsonError.fromJson(jsonDecode(error)).err.toString();
    }

    ///Status Response Success
    if (isResponseSuccess(response.statusCode)) {
      return response.body;
    }

    ///Status Response ErrorNetwork
    else if (isResponseErrorNetwork(response.statusCode)) {
      throw response.statusCode.toString();
    } else{
      throw  response.statusCode.toString();
    }

    ///Other Server Response mess
  }
}