import 'dart:async';

import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/base_view_model.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

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
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(())).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState,
          failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputBannerAd.add(homeObject.data?.banners);
      inputStore.add(homeObject.data?.stores);
      inputService.add(homeObject.data?.services);
    });
  }

  @override
  void dispose() {
    _bannerStreamController.close();
    _storeStreamController.close();
    _serviceStreamController.close();
    super.dispose();
  }

  // * inputs *

  @override
  Sink get inputBannerAd => _bannerStreamController.sink;
  @override
  Sink get inputService => _serviceStreamController.sink;
  @override
  Sink get inputStore => _storeStreamController.sink;
  // * outputs *
  @override
  Stream<List<BannerAd>> get outputBannerAd =>
      _bannerStreamController.stream.map((banner) => banner);

  @override
  Stream<List<Service>> get outputService =>
      _serviceStreamController.stream.map((service) => service);

  @override
  
  Stream<List<Store>> get outputStore =>
      _storeStreamController.stream.map((store) => store);
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
