import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';
import 'package:flutter_advanced/domain/usecase/base_usecase.dart';

import '../../data/request/request.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) {
    return _repository
        .login(LoginRequest(input.email, input.password, "imei", "deviceType"));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
