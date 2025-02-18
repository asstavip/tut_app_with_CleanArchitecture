import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/constant.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(minutes: Constant.API_TIMEOUT),
      receiveTimeout: Duration(minutes: Constant.API_TIMEOUT),
      headers: headers,
    );

    dio.options.baseUrl = Constant.baseUrl;

      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ));
    return dio;
  }
}
