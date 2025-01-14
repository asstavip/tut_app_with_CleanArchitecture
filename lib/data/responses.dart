import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;

}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotifications')
  int? numOfNotifications;

  CustomerResponse(this.id,this.name,this.numOfNotifications);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'link')
  String? link;

  ContactsResponse(this.phone,this.email,this.link);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer,this.contacts);

  //from json


  //to json
}
