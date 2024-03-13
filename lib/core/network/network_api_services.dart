import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../usecases/app_exception.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  static var client = http.Client();

  // get api
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response =
          await client.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  // get api with header
  Future<dynamic> getHeaderApi(Map<String, String>? header, String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await client
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  //post api
  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print("api url :- ${url.toString()}");
      print("data :- ${data.toString()}");
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data).toString())
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    }
    return responseJson;
  }

  Future<dynamic> postApiOnly(String url) async {
    if (kDebugMode) {
      print("api url :- ${url.toString()}");
    }

    dynamic responseJson;
    try {
      final response =
          await http.post(Uri.parse(url)).timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    }
    return responseJson;
  }

  // post api with header
  Future<dynamic> postHeaderApi(
      {required Map<String, String>? header,
      required Object? data,
      required String url}) async {
    if (kDebugMode) {
      print("api url :- ${url.toString()}");
      print("data :- ${data.toString()}");
      print("header :- ${header.toString()}");
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: header, body: jsonEncode(data).toString())
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } on HttpException {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  // delete api with header
  Future<dynamic> deleteHeaderApi(
     {required Map<String, String>? header,
      required Object? data,
      required String url}) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await client
          .delete(Uri.parse(url), body: jsonEncode(data).toString(), headers: header)
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  // put api with header
  Future<dynamic> putheaderApi(
      {required Map<String, String>? header,
      // required Object? data,
      required Map<String, String> data,
      required String url}) async {
    if (kDebugMode) {
      print("api url :- ${url.toString()}");
      print("data :- ${data.toString()}");
      print("header :- ${header.toString()}");
    }

    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(url),
              headers: header, body: jsonEncode(data).toString())
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } on HttpException {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  Future<dynamic> patchheaderApi(
      {required Map<String, String>? header,
      // required Object? data,
      required Map<String, String> data,
      required String url}) async {
    if (kDebugMode) {
      print("api url :- ${url.toString()}");
      print("data :- ${data.toString()}");
      print("header :- ${header.toString()}");
    }

    dynamic responseJson;
    try {
      final response = await http
          .patch(Uri.parse(url),
              headers: header, body: jsonEncode(data).toString())
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } on HttpException {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  Future<dynamic> patchWithoutHeaderApi(
      {required Map<String, String>? data, required String url}) async {
    if (kDebugMode) {
      print("api url :- ${url.toString()}");
      print("data :- ${data.toString()}");
    }
    dynamic responseJson;
    try {
      final response = await http.patch(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } on HttpException {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  Future<dynamic> patchwithheaderApi(
      {required Map<String, String>? header, required String url}) async {
    if (kDebugMode) {
      print("api url :- ${url.toString()}");

      print("header :- ${header.toString()}");
    }

    dynamic responseJson;
    try {
      final response = await http
          .patch(
            Uri.parse(url),
            headers: header,
          )
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } on HttpException {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  Future<dynamic> putApiWithOnlyToken(
      Map<String, String>? header, String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    // final String jsonString = jsonEncode(data);
    try {
      final response = await http
          .put(
            Uri.parse(url),
            headers: header,
          )
          .timeout(const Duration(seconds: 60));
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } on HttpException {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }
  Future<dynamic> putApiWithoutHeader(
      Map<String, String>? data, String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    // final String jsonString = jsonEncode(data);
    try {
         final response = await http.put(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 30));
      
      responseJson = returnResponce(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } on HttpException {
      throw RequestTimeOut("");
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  // handling responce
  dynamic returnResponce(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 202:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        dynamic responseJson = jsonDecode(response.body);
        debugPrint("Server Responce 400 :- ${responseJson.toString()}");
        return responseJson;

      case 401:
        dynamic responseJson = jsonDecode(response.body);
        debugPrint("Server Responce 401 :- ${responseJson.toString()}");

        return responseJson;

      case 403:
        dynamic responseJson = jsonDecode(response.body);
        debugPrint("Server Responce 403 :- ${responseJson.toString()}");

        return responseJson;

      case 404:
        dynamic responseJson = jsonDecode(response.body);
        debugPrint("Server Responce 404 :- ${responseJson.toString()}");

        return responseJson;

      case 422:
        dynamic responseJson = jsonDecode(response.body);
        debugPrint("Server Responce 422 :- ${responseJson.toString()}");
        return responseJson;

      case 500:
        dynamic responseJson = jsonDecode(response.body);
        debugPrint("Internal Server Error 500 :- ${responseJson.toString()}");
        return responseJson;

      default:
        throw FetchDataException(response.statusCode.toString());
    }
  }
}
