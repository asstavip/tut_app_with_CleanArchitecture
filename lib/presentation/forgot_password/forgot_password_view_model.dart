import 'dart:async';

import 'package:flutter_advanced/app/functions.dart';
import 'package:flutter_advanced/domain/usecase/forget_password_usecase.dart';
import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

import '../resources/color_pallete.dart';

abstract class ForgotPasswordViewModelInputs {
  forgotPassword(String email);
  setEmail(String email);
  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final ForgetPasswordUseCase _forgetPasswordUsecase;
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _isAllInputsValidStreamController =
      StreamController<void>.broadcast();


  ForgotPasswordViewModel(this._forgetPasswordUsecase);

  var email = '';

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  // input
  @override
  void start() {
    inputState.add(ContentState());
  }

  // output
  @override
  forgotPassword(String email) async {
    // Show loading state
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUsecase.execute(email)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (supportMessage) {
      inputState.add(SuccessState(supportMessage));
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputsValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }


}
