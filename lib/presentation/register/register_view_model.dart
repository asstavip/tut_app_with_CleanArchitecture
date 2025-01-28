import 'dart:async';
import 'dart:io';

import '../base/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
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

  @override
  void start() {
    // TODO: implement start
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
}
