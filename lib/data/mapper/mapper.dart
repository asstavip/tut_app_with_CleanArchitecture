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

extension ServicesResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id?.orZero() ?? Constant.ZERO,
      this?.title?.orEmpty() ?? Constant.EMPTY,
      this?.image?.orEmpty() ?? Constant.EMPTY,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id?.orZero() ?? Constant.ZERO,
      this?.title?.orEmpty() ?? Constant.EMPTY,
      this?.image?.orEmpty() ?? Constant.EMPTY,
    );
  }
}

extension BannerResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id?.orZero() ?? Constant.ZERO,
      this?.title?.orEmpty() ?? Constant.EMPTY,
      this?.image?.orEmpty() ?? Constant.EMPTY,
      this?.link?.orEmpty() ?? Constant.EMPTY,
    );
  }
}

extension HomeResponseMapper on HomeResponse?{
  HomeObject toDomain(){
    List<Service> services = (this?.data?.services?.map((service) => service.toDomain()).toList() ?? []).cast<Service>();
    List<BannerAd> banners = (this?.data?.banners?.map((banner) => banner.toDomain()).toList() ?? []).cast<BannerAd>();
    List<Store> stores = (this?.data?.stores?.map((store) => store.toDomain()).toList() ?? []).cast<Store>();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      this?.status?.orZero() ?? Constant.ZERO,
      this?.message?.orEmpty() ?? Constant.EMPTY,
      this?.image?.orEmpty() ?? Constant.EMPTY,
      this?.id?.orZero() ?? Constant.ZERO,
      this?.title?.orEmpty() ?? Constant.EMPTY,
      this?.details?.orEmpty() ?? Constant.EMPTY,
      this?.services?.orEmpty() ?? Constant.EMPTY,
      this?.about?.orEmpty() ?? Constant.EMPTY,
    );
  }
}