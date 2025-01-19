import 'dart:async';

import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and functions that will be used trough any view model
  StreamController _inputStreamController = StreamController<
      FlowState>.broadcast(); // shared stream between view model and view
  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  // events that will trigger the view model actions
  void start(); // will be called while init . of view model
  void dispose(); // will be called while deinit . of view model

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  // events that will trigger the view to update
  Stream<FlowState> get outputState;
}
