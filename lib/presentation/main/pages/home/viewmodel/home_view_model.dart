import 'dart:async';
import 'dart:developer';

import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel{

  final StreamController _bannerStreamController = BehaviorSubject<List<BannerAd>>();
  final StreamController _storeStreamController = BehaviorSubject<List<Store>>();
  final StreamController _serviceStreamController = BehaviorSubject<List<Service>>();

  final HomeUseCase _homeUseCase ;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {

  }

  @override
  void dispose() {
    _bannerStreamController.close();
    _storeStreamController.close();
    _serviceStreamController.close();
    super.dispose();
  }
}