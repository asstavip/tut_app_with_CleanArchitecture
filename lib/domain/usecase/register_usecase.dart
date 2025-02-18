import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';
import 'package:flutter_advanced/domain/usecase/base_usecase.dart';

import '../../data/request/request.dart';

class RegisterUsecase implements BaseUseCase<RegisterUsecaseInput, Authentication> {
  Repository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUsecaseInput input) async {
    return _repository.register(RegisterRequest(input.userName, input.countryCode, input.mobileNumber, input.email, input.password, input.profilePicture));
  }
}

class RegisterUsecaseInput {
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUsecaseInput(this.userName, this.countryCode, this.mobileNumber, this.email,this.password, this.profilePicture);
}
