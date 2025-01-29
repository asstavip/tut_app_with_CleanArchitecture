import 'dart:async';
import 'dart:io';

import 'package:flutter_advanced/app/constant.dart';
import 'package:flutter_advanced/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

import '../../app/functions.dart';
import '../base/base_view_model.dart';
import '../common/freezed_data_classes.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_impl.dart';

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
  var registerObject = RegisterObject("", "", "", "", "", "");

  RegisterViewModel(this._registerUsecase);

  @override
  void start() {
    inputState.add(ContentState());
  }

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

  @override
  Sink get inputsAreValid => areAllInputsValidStreamController.sink;
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

  /*
  this is the output of the areAllInputsValid
   */
  @override
  Stream<bool> get outputAreAllInputsValid => areAllInputsValidStreamController.stream.map((_)=> _isAllInputsValid());
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
  bool _isAllInputsValid(){
    return registerObject.userName.isNotEmpty && registerObject.email.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty && registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty && registerObject.countryCode.isNotEmpty;
  }

  validate(){
    inputsAreValid.add(null);
  }

  @override
  register() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    try {
      final result = await _registerUsecase
          .execute(RegisterUsecaseInput(registerObject.userName, registerObject.countryCode, registerObject.mobileNumber, registerObject.email, registerObject.password, registerObject.profilePicture));
      result.fold((failure) {
        // left -> failure
        inputState.add(
            ErrorState(StateRendererType.popupErrorState, failure.message));
      }, (data) {
        // right -> data (success)
        // content
        inputState.add(ContentState());
        // navigate to main screen

      });
    } catch (e) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, e.toString()));
    }
  }

  @override
  setCountryCode(String countryCode) {
    if ((countryCode).isNotEmpty) {
      registerObject = registerObject.copyWith(countryCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryCode: Constant.EMPTY);
    }
    validate();
  }

  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    }else{
      registerObject = registerObject.copyWith(email: Constant.EMPTY);
    }
    validate();
  }

  @override
  setMobile(String mobile) {
    if (_isMobileValid(mobile)) {
      registerObject = registerObject.copyWith(mobileNumber: mobile);
    }else{
      registerObject = registerObject.copyWith(mobileNumber: Constant.EMPTY);
    }
    validate();
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: Constant.EMPTY);
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    if (profilePicture.path.isNotEmpty) {
      registerObject = registerObject.copyWith(profilePicture: profilePicture.path);
    }else{
      registerObject = registerObject.copyWith(profilePicture: Constant.EMPTY);
    }
    validate();
  }

  @override
  setUserName(String userName) {
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: Constant.EMPTY);
    }
    validate();
  }

}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;

  Sink get inputMobile;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputsAreValid;

  register();

  setUserName(String userName);

  setMobile(String mobile);

  setCountryCode(String countryCode);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File profilePicture);
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

  Stream<bool> get outputAreAllInputsValid;

}
