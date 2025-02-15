import 'dart:async';

import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannerStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _storeStreamController =
      BehaviorSubject<List<Store>>();
  final StreamController _serviceStreamController =
      BehaviorSubject<List<Service>>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    _bannerStreamController.close();
    _storeStreamController.close();
    _serviceStreamController.close();
    super.dispose();
  }

  // * inputs *

  @override
  // TODO: implement inputBannerAd
  Sink get inputBannerAd => _bannerStreamController.sink;

  @override
  // TODO: implement inputService
  Sink get inputService => _serviceStreamController.sink;

  @override
  // TODO: implement inputStore
  Sink get inputStore => _storeStreamController.sink;

  // * outputs *
  @override
  // TODO: implement outputBannerAd
  Stream<List<BannerAd>> get outputBannerAd => _bannerStreamController.stream.map((banner) => banner);

  @override
  // TODO: implement outputService
  Stream<List<Service>> get outputService => _serviceStreamController.stream.map((service) => service);

  @override
  // TODO: implement outputStore
  Stream<List<Store>> get outputStore => _storeStreamController.stream.map((store) => store);
}

abstract class HomeViewModelInput {
  Sink get inputBannerAd;

  Sink get inputStore;

  Sink get inputService;
}

abstract class HomeViewModelOutput {
  Stream<List<BannerAd>> get outputBannerAd;

  Stream<List<Store>> get outputStore;

  Stream<List<Service>> get outputService;
}
