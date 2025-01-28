import 'dart:async';
import 'dart:io';

import 'package:flutter_advanced/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

import '../../app/functions.dart';
import '../base/base_view_model.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInputs, RegisterViewModelOutputs {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController mobileStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  // inputs
  final RegisterUsecase _registerUsecase;

  RegisterViewModel(this._registerUsecase);

  @override
  void start() {}

  @override
  void dispose() {
    super.dispose();
    userNameStreamController.close();
    mobileStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
  }

//inputs
  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobile => mobileStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  // outputs

  /*
  this is the output of the username
   */
  @override
  Stream<String?> get outputErrorUserName =>
      userNameStreamController.stream.map((isUserNameValid) =>
          isUserNameValid ? null : AppStrings.invalidUserName);

  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  /*
  this is the output of the email
   */

  @override
  Stream<String?> get outputErrorEmail => emailStreamController.stream
      .map((isEmailValid) => isEmailValid ? null : AppStrings.emailError);

  @override
  Stream<bool> get outputIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  /*
  this is the output of the mobile
   */
  @override
  Stream<String?> get outputErrorMobile => mobileStreamController.stream.map(
      (isMobileValid) => isMobileValid ? null : AppStrings.invalidMobileNumber);

  @override
  Stream<bool> get outputIsMobileValid =>
      mobileStreamController.stream.map((mobile) => _isMobileValid(mobile));

  /*
  this is the output of the password
   */
  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => passwordStreamController.stream
      .map((isPassword) => isPassword ? null : AppStrings.invalidPassword);

  @override
  Stream<File> get outputProfilePicture => profilePictureStreamController.stream
      .map((profilePicture) => profilePicture);

  // _private functions
  bool _isUserNameValid(String userName) {
    return userName.length > 4;
  }

  bool _isMobileValid(String mobile) {
    return mobile.length >= 9;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;

  Sink get inputMobile;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileValid;

  Stream<String?> get outputErrorMobile;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;
}
