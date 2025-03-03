// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/data_source/local_data_source.dart';
import 'package:flutter_advanced/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced/data/mapper/mapper.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/data/network/network_info.dart';
import 'package:flutter_advanced/data/request/request.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';

import '../network/error_handler.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNETCTION.getFailure());
    }
  }

  @override

  /// Sends a reset password request to the server.
  ///
  /// If the request is successful, return a Right with the response message.
  /// If the request fails, return a Left with a Failure object.
  /// If the device is not connected to the internet, return a Left with a Failure object with
  /// the code DataSource.NO_INTERNET_CONNETCTION and the message "No internet connection".
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNETCTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNETCTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
      // get response from cache
    } catch (cacheError) {
      // cache is Not exist
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHomeData();
          if (response.status == ApiInternalStatus.SUCCESS) {
            // save response in cache
            _localDataSource.saveHomeCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.UNKNOWN));
          }
        } catch (e) {
          return Left(ErrorHandler.handle(e).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNETCTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async{
    
    try {
      final response = await _localDataSource.getStoreDetails();
      
      return Right(response.toDomain());
    } catch (cacheError) {
      
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getStoreDetails();
          
          if (response.status == ApiInternalStatus.SUCCESS) {
            
            _localDataSource.saveStoreDetailsCache(response);
            return Right(response.toDomain());
          } else {
            
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.UNKNOWN));
          }
        } catch (e) {
          
          return Left(ErrorHandler.handle(e).failure);
        }
      } else {
        
        return Left(DataSource.NO_INTERNET_CONNETCTION.getFailure());
      }
    }
  }
}
