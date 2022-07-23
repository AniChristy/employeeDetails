// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'apiurls.dart';

class DioHelper {
  Dio dio = Dio();

  int retryAttempt = 0;

  DioHelper() {
    dio.options.baseUrl = ApiUrls.baseUrl;

    //Giving a common header
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

    dio.transformer = JsonTransformer();

    //setting upto which status code to listen to
    dio.options.validateStatus = (int? status) {
      return status! < 400;
    };

    _setupAuthInterceptor();
    _setupDebugInterceptor();
    _setupRetryInterceptor();
  }

  _setupRetryInterceptor() {
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      retries: 4,

      // retryEvaluator: checkDioRetry,
    ));
  }

  _setupAuthInterceptor() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? _token = prefs.getString('token') ?? null;
      String? _tokenExpiryDateAndTime = prefs.getString("tokenExpiryDateTime") ?? null;

      options.headers = Map();
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $_token";

      // if (_token != null) {
      //   DateTime _tokenExpiryDateAndTimeInDateAndTimeFormat = DateTime.parse(_tokenExpiryDateAndTime!);
      //   DateTime _currentDateAndTime = DateTime.now();
      //   if (_currentDateAndTime.isAfter(_tokenExpiryDateAndTimeInDateAndTimeFormat) ) {
      //     await _refreshToken(dio);
      //     options.headers = Map();
      //     _token = prefs.getString('token');
      //     _tokenExpiryDateAndTime = prefs.getString("tokenExpiryDateTime");
      //     options.headers[HttpHeaders.authorizationHeader] = "Bearer $_token";
      //   }else{
      //     options.headers = Map();
      //     options.headers[HttpHeaders.authorizationHeader] = "Bearer $_token";
      //   }
      //
      // }

      // options.data["token"] = true;
      return handler.next(options);
    }, onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
      //on response
      return handler.next(response);
    }, onError: (error, handler) async {
      if (error.type == DioErrorType.response) {
        switch (error.response!.statusCode) {
          case 401:
            EasyLoading.showError(error.response!.data.toString());
            // Utils.showToast("401 called");
            // await _refreshToken(dio);
            break;
          case 403:
            EasyLoading.showError(error.response!.data.toString());
            // Utils.showToast("403 Forbidden");
            break;
          case 404:
            EasyLoading.showError(error.response!.data.toString());
            // Utils.showToast("404 Forbidden");
            break;
          case 429:
            EasyLoading.showError(error.response!.data.toString());
            // Utils.showToast("Too many Requests");
            break;
          case 500:
            EasyLoading.showError(error.response!.data.toString());
            // Utils.showToast(error.response!.data[0]['errorMessage'].toString());
            break;
          case 405:
            EasyLoading.showError(error.response!.data.toString());
            // Utils.showToast("405 Method not allowed");
            break;
        }
        
      } else if (error.type == DioErrorType.sendTimeout) {
        EasyLoading.showError(error.response!.data[0]['errorMessage'].toString());
        // Utils.showToast("Please check you internet connection");
      } else {
        EasyLoading.showError(error.message);
        // Utils.showToast(error.message);
      }

      //on error
      // return handler.next(error);
    }));
  }

  FutureOr<bool> checkDioRetry(DioError error, int? num) {
    retryAttempt += 1;
    return error.type == DioErrorType.other;
  }

  _refreshToken(Dio dio) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _token = prefs.getString('token');
    String? _refreshtoken = prefs.getString('refreshToken');
    String _url = ApiUrls.baseUrl + "/api/memberlogin/tokenbyrefreshtoken";

    dio.lock();
    final response = await Dio().post(
      _url,
      data: {"token": "$_token", "refreshToken": "$_refreshtoken"},
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      ),
    );
    prefs.setString("token", response.data['token']);
    prefs.setString("refreshToken", response.data['refreshToken']);
    prefs.setString("tokenExpiryDateTime", response.data['tokenExpiryDateTime']);
    prefs.setBool("familyHead", response.data['familyHead']);
    prefs.setString("displayName", response.data['displayName']);
    prefs.setString("country", response.data['country']);
    prefs.setString("contactNumber", response.data['contactNumber']);
    if(response.data['razorpayKey'] != null){
      prefs.setString("razorpayKey", response.data['razorpayKey']);
    }
    // print('member Image Before saving is ' + _memberImage.toString());
    if(response.data['memberImage'] != null && response.data['memberImage'].toString().isNotEmpty){
      prefs.setString("memberImage", response.data['memberImage']);

      // print('member Image after saving is ' + prefs.getString('memberImage').toString());
    }
    
    
    if (response.data['youtubeChannelLink'] != null) {
      prefs.setString("youtubeChannelLink", response.data['youtubeChannelLink']);
    }
    print(response.data['tokenExpiryDateTime']);
    dio.unlock();
  }

  _setupDebugInterceptor() {
    if (DebugMode.isInDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }
}

class JsonTransformer extends DefaultTransformer {
  JsonTransformer() : super(jsonDecodeCallback: _parseJson);
}

dynamic _parseAndDecode(String response) {
  return jsonDecode(response) as dynamic;
}

Future<dynamic> _parseJson(String text) {
  return compute(_parseAndDecode, text);
}

Dio dio() {
  final Dio dio = DioHelper().dio;
  return dio;
}

class DebugMode {
  static bool get isInDebugMode {
    const bool inDebugMode = true;

    return inDebugMode;
  }
}
