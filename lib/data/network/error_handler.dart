// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNETCTION,
  UNKNOWN
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its errors from response of the API
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.UNKNOWN.getFailure();
    }
  }
  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.UNKNOWN.getFailure();
      case DioExceptionType.badResponse:
        return DataSource.BAD_REQUEST.getFailure();
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.NO_INTERNET_CONNETCTION.getFailure();
      case DioExceptionType.unknown:
        return DataSource.UNKNOWN.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNETCTION:
        return Failure(
            ResponseCode.NO_INTERNET_CONNETCTION, ResponseMessage.NO_INTERNET_CONNETCTION);
      default:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }
}

class ResponseCode {
  // API status code
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTHORIZED = 401; // failure, user is not authorized
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int UNKNOWN = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNETCTION = -7;
}

class ResponseMessage {
  // API status code
  static String SUCCESS = AppStrings.success.tr(); // success with data
  static  String NO_CONTENT = AppStrings.noContent.tr(); // success with no data (no content)
  static  String BAD_REQUEST = AppStrings.badRequestError.tr(); // failure, API rejected request
  static  String UNAUTHORIZED = AppStrings.unauthorizedError.tr(); // failure, user is not authorized
  static  String FORBIDDEN = AppStrings.forbiddenError.tr(); //  failure, API rejected request
  static  String INTERNAL_SERVER_ERROR = AppStrings.internalServerError.tr(); // failure, crash in server side
  static  String NOT_FOUND = AppStrings.notFoundError.tr(); // failure, not found
 

  // local status code
  static  String UNKNOWN = AppStrings.unknownError.tr();
  static  String CONNECT_TIMEOUT = AppStrings.timeoutError.tr();
  static  String CANCEL = AppStrings.defaultError.tr();
  static  String RECEIVE_TIMEOUT = AppStrings.timeoutError.tr();
  static  String SEND_TIMEOUT = AppStrings.timeoutError.tr();
  static  String CACHE_ERROR = AppStrings.cacheError.tr();
  static  String NO_INTERNET_CONNETCTION = AppStrings.noInternetError.tr();
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}