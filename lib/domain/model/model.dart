class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contact {
  String email;
  String phone;
  String link;

  Contact(this.email, this.phone, this.link);
}

class Authentication {
  Customer? customer;
  Contact? contact;

  Authentication(this.customer, this.contact);
}

class DeviceInfo{
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}

class Service{
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}
class BannerAd{
  int id;
  String title;
  String image;
  String link;

  BannerAd(this.id, this.title, this.image, this.link);
}

class Store{
  int id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
} 

class HomeData{
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject{
  HomeData data;
  
  HomeObject(this.data);
}