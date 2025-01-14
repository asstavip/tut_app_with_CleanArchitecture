// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_advanced/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced/data/mapper/mapper.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/data/network/network_info.dart';
import 'package:flutter_advanced/data/request/request.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';

import '../network/error_handler.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status?? ApiInternalStatus.FAILURE,response.message ?? ResponseMessage.UNKNOWN));
        }
      }catch (e) {
         return Left(ErrorHandler.handle(e).failure);
      }
    } else {
          return Left(DataSource.NO_INTERNET_CONNETCTION.getFailure());
    }
  }
}
