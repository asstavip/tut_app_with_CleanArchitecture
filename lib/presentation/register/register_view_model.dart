import 'dart:async';
import 'dart:io';

import 'package:flutter_advanced/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

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
  @override
  Stream<String?> get outputErrorEmail => throw UnimplementedError();

  @override
  Stream<String?> get outputErrorMobile => throw UnimplementedError();

  @override
  Stream<String?> get outputErrorPassword => throw UnimplementedError();

  @override
  Stream<String?> get outputErrorUserName => userNameStreamController.stream.map((isUserNameValid)=>
  isUserNameValid ? null : AppStrings.invalidUserName
  );

  @override
  Stream<bool> get outputIsEmailValid => throw UnimplementedError();

  @override
  Stream<bool> get outputIsMobileValid => throw UnimplementedError();

  @override
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  Stream<bool> get outputIsUserNameValid =>
      userNameStreamController.stream.map((userName) =>
          _isUserNameValid(userName));

  @override
  Stream<bool> get outputProfilePicture => throw UnimplementedError();

  bool _isUserNameValid(String userName) {
    return userName.length > 4;
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

  Stream<bool> get outputProfilePicture;
}
