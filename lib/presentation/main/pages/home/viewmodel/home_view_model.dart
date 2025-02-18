import 'dart:async';
import 'dart:ffi';

import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/base_view_model.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInput, HomeViewModelOutput {
  // Use a single StreamController for HomeViewObject
  final StreamController _homeStreamController =
      BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      // Emit HomeViewObject containing banners, services, and stores
      inputHomeData.add(
        HomeViewObject(
          homeObject.data.banners,
          homeObject.data.services,
          homeObject.data.stores,
        ),
      );
    });
  }

  @override
  void dispose() {
    _homeStreamController.close();
    super.dispose();
  }

  // * inputs *
  @override
  Sink get inputHomeData => _homeStreamController.sink;

  // * outputs *
  @override
  Stream<HomeViewObject> get outputHomeData => _homeStreamController.stream.map(
        (homeViewObject) => homeViewObject,
      );
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  final List<BannerAd> banners;
  final List<Service> services;
  final List<Store> stores;

  HomeViewObject(this.banners, this.services, this.stores);
}
