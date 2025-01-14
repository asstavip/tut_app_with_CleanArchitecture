// to convert the response into a non nullable object(model)

import 'package:flutter_advanced/app/extensions.dart';
import 'package:flutter_advanced/data/responses/responses.dart';
import 'package:flutter_advanced/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.numOfNotifications?.orZero() ?? ZERO,
    );
  }
}


extension ContactsResponseMapper on ContactsResponse? {
  Contact toDomain() {
    return Contact(
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
    );
  }
} 

extension AuthenticationResponseMapper on AuthenticationResponse?{

  Authentication toDomain(){
    return Authentication(
      this?.customer?.toDomain() ,
      this?.contacts?.toDomain() ,
    );
  }

}