import 'package:dio/dio.dart';
import 'package:flutter_advanced/app/constant.dart';
import 'package:flutter_advanced/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Header("imie") String imie,
    @Header("deviceType") String deviceType,
  );

  @POST("/customers/forgot-password")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      @Field("user_name") String userName,
      @Field("country_code") String countryCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_picture") String profilePicture,);
}
