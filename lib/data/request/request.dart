class LoginRequest{
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(this.email, this.password, this.imei, this.deviceType);
}

class RegisterRequest{
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterRequest(this.userName, this.countryCode, this.mobileNumber, this.email,this.password, this.profilePicture);
}