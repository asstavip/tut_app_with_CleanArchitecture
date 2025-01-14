import 'dart:async';

import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/freezed_data_classes.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject(email: '', password: '');

  @override
  void dispose() {
    // TODO: implement dispose
    _emailStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get isPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password); // data class operation same as kotlin
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
}

abstract class LoginViewModelOutputs {
  // two streams
  Stream<bool> get isEmailValid;

  Stream<bool> get isPasswordValid;
}
