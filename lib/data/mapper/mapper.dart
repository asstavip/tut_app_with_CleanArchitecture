// to convert the response into a non nullable object(model)

import 'package:flutter_advanced/app/constant.dart';
import 'package:flutter_advanced/app/extensions.dart';
import 'package:flutter_advanced/data/responses/responses.dart';
import 'package:flutter_advanced/domain/model/model.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? Constant.EMPTY,
      this?.name?.orEmpty() ?? Constant.EMPTY,
      this?.numOfNotifications?.orZero() ?? Constant.ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contact toDomain() {
    return Contact(
      this?.email?.orEmpty() ?? Constant.EMPTY,
      this?.phone?.orEmpty() ?? Constant.EMPTY,
      this?.link?.orEmpty() ?? Constant.EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer?.toDomain(),
      this?.contacts?.toDomain(),
    );
  }
}
extension ForgetPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constant.EMPTY;
  }
}