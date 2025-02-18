import 'dart:async';
import 'dart:ffi';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/store_details_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/base_view_model.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final StreamController<StoreDetails> _storeDetailsStreamController =
      BehaviorSubject<StoreDetails>();

  final StoreDetailsUsecase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    _getStoreDetails();
  }

  _getStoreDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _storeDetailsUseCase.execute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (storeDetails) {
      inputState.add(ContentState());
      inputStoreDetails.add(storeDetails);
    });
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }
  // * inputs *
  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  // * outputs *
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
