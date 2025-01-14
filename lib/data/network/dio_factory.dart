import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/constant.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeout = 1;
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: "en" // TODO: get language from settings
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(minutes: _timeout),
      receiveTimeout: Duration(minutes: _timeout),
      headers: headers,
    );

    dio.options.baseUrl = Constant.baseUrl;
    if(kReleaseMode){
      print("Release Mode");
    }else
    {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
