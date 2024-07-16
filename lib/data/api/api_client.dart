import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../controller/auth_controller.dart';
import '../../util/app_constants.dart';
import '../../view/base/show_snackbar.dart';
import '../model/base/error_response.dart';

class ApiClient extends GetxService {
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  late Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ',
    'Accept': 'application/json',
    'zoneId': ' ',
  };

  String? token;

  ApiClient() {
  }

  Future<void> updateHeader(String? token, String? zoneId) async {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'zoneId': '$zoneId',
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      log('====> API Call: Header: $_mainHeaders');
      log('====> API Call: Url: ${AppConstants.baseUrl}$uri');
      http.Response response = await http
          .get(
            Uri.parse(AppConstants.baseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      log('====> API Call: Header: $_mainHeaders');
      log('====> API Call: Url: ${AppConstants.baseUrl}$uri');
      log('====> API Body: $body');
      http.Response response = await http
          .post(
            Uri.parse(AppConstants.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      log('====> API Call: Header: $_mainHeaders');
      log('====> API Call: Url: ${AppConstants.baseUrl}$uri');
      log('====> API Body: $body');
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(AppConstants.baseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (foundation.kIsWeb) {
          Uint8List list = await multipart.file.readAsBytes();
          http.MultipartFile part = http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            list.length,
            filename: basename(multipart.file.path),
            contentType: MediaType('image', 'jpg'),
          );
          request.files.add(part);
        } else {
          File file = File(multipart.file.path);
          request.files.add(http.MultipartFile(
            multipart.key,
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      log('====> API Call: Header: $_mainHeaders');
      log('====> API Call: Url: ${AppConstants.baseUrl}$uri');
      log('====> API Body: $body');
      http.Response response = await http
          .put(
            Uri.parse(AppConstants.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      log('====> API Call: $uri\nHeader: $_mainHeaders');
      http.Response response = await http
          .delete(
            Uri.parse(AppConstants.baseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(http.Response res, String uri) {
    dynamic body;
    try {
      body = jsonDecode(res.body);
      debugPrint(body.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    Response response = Response(
      body: body ?? res.body,
      bodyString: res.body.toString(),
      request: Request(
          headers: res.request!.headers,
          method: res.request!.method,
          url: res.request!.url),
      headers: res.headers,
      statusCode: res.statusCode,
      statusText: res.reasonPhrase,
    );
    if (response.statusCode != 200 &&
        response.body != null &&
        response.body is! String) {
      if (response.statusCode == 401) {
        showCustomSnackBar('401', isError: true);/*
        Get.find<AuthController>().isLoggedIn();*/
      } else if (response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
        response = Response(
            statusCode: response.statusCode,
            body: response.body,
            statusText: errorResponse.errors![0].message);
      } else if (response.body.toString().startsWith('{status')) {
        response = Response(
            statusCode: response.statusCode,
            body: response.body,
            statusText: response.body['message']);
      }
    } else if (response.statusCode != 200 && response.body == null) {
      response = const Response(
        statusCode: 0,
        statusText: noInternetMessage,
      );
    }

    if (!(response.body.toString().startsWith('{'))) {
      log('====> API Response: [${response.statusCode}] $uri\n${json.encode(response.body.toString())}');
      response = Response(
          statusCode: response.statusCode,
          body: {"status": false, "message": "Internal Server Error"},
          statusText: "Internal Server Error");
    }
    return response;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
