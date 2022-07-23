// ignore_for_file: file_names, avoid_print

import 'dart:async';


import 'package:anitask/Models/GetUserList.dart';
import 'package:dio/dio.dart';

import 'apiurls.dart';
import 'diohelper.dart';

class ApiService {

  Future<GetUserDetiailsResModel> getUserDetails() async {

    var url = ApiUrls.userList;

    final response = await dio()
        .post(url,)
        .catchError((error) {
      DioError dioError = error;
      print(dioError.response!.statusCode);
    });

    if (response.statusCode == 200) {
      return GetUserDetiailsResModel.fromJson(response.data as List<dynamic>);
    } else {
      throw Exception(response.statusCode.toString());
    }
  }

}
