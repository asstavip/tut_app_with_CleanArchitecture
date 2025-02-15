import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';
import 'package:flutter_advanced/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
