import 'dart:async';

import 'package:flutter_advanced/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/freezed_data_classes.dart';

import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _allInputsAreValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject(email: '', password: '');

  LoginUseCase? _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _passwordStreamController.close();
    _allInputsAreValidStreamController.close();
  }

  @override
  void start() {
    // view model should tell the view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputsAreValid => _allInputsAreValidStreamController.sink;

  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get isPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  Stream<bool> get isAllInputsAreValid =>
      _allInputsAreValidStreamController.stream.map((_) =>
          _isEmailValid(loginObject.email) &&
          _isPasswordValid(loginObject.password));

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    try {
      final result = await _loginUseCase
          ?.execute(LoginUseCaseInput(loginObject.email, loginObject.password));
      result?.fold((failure) {
        inputState.add(
            ErrorState(StateRendererType.popupErrorState, failure.message));
      }, (data) {
        inputState.add(ContentState());
      });
    } catch (e) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, e.toString()));
    }
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
  }

  bool _isPasswordValid(String password) {
    // Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    // TODO : remove comments and implement password validation
    // final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    // return regex.hasMatch(password);
    return password.isNotEmpty;
  }

  bool _isEmailValid(String email) {
    // TODO : search for a valid regex after test
    return email.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  // tree functions
  setEmail(String email);

  setPassword(String password);

  login();

  // two sinks
  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputsAreValid;
}

abstract class LoginViewModelOutputs {
  // two streams
  Stream<bool> get isEmailValid;

  Stream<bool> get isPasswordValid;
}
