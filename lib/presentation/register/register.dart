import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced/app/constant.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/register/register_view_model.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';

import '../../app/di.dart';
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  void _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _mobileController
        .addListener(() => _viewModel.setMobile(_mobileController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryWhite,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorPallete.primaryWhite,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorPallete.primaryWhite,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context, _getContentWidget(), _viewModel.register()) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p28),
      color: ColorPallete.primaryWhite,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: AppSize.s18,
            children: [
              Center(
                child: Image(
                  image: const AssetImage(ImageAssets.splashLogo),
                ),
              ),
              // * UserName Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      style: TextStyle(color: ColorPallete.primaryGray),
                      cursorColor: ColorPallete.primaryOrange,
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: ColorPallete.primaryGray),
                          focusColor: ColorPallete.primaryOrange,
                          labelText: AppStrings.username,
                          hintText: AppStrings.hintUserName,
                          errorText: (snapshot.data)
                      ),
                    );
                  },
                ),
              ),
              // * Mobile Section + Country Code Picker
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: Row(
                    children: [
                      // * Country Code Picker
                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          initialSelection: '+212',
                          favorite: ['+212', 'MA'],
                          showCountryOnly: true,
                          hideMainText: true,
                          showOnlyCountryWhenClosed: true,
                          onChanged: (country) {
                            print(country.dialCode);
                            _viewModel.setCountryCode(country.code?? Constant.token);
                          },
                        ),
                      ),
                      // * Mobile Number
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<String?>(
                          stream: _viewModel.outputErrorMobile,
                          builder: (context, snapshot) {
                            return TextFormField(
                              style: TextStyle(color: ColorPallete.primaryGray),
                              cursorColor: ColorPallete.primaryOrange,
                              controller: _mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: ColorPallete.primaryGray),
                                focusColor: ColorPallete.primaryOrange,
                                labelText: AppStrings.mobile,
                                hintText: AppStrings.hintMobile,
                                errorText: (snapshot.data)
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // * Email Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      style: TextStyle(color: ColorPallete.primaryGray),
                      cursorColor: ColorPallete.primaryOrange,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: ColorPallete.primaryGray),
                        focusColor: ColorPallete.primaryOrange,
                        labelText: AppStrings.email,
                        hintText: AppStrings.hintEmail,
                        errorText: (snapshot.data)
                      ),
                    );
                  },
                ),
              ),
              // * Password Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      style: TextStyle(color: ColorPallete.primaryGray),
                      cursorColor: ColorPallete.primaryOrange,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: ColorPallete.primaryGray),
                        focusColor: ColorPallete.primaryOrange,
                        labelText: AppStrings.password,
                        hintText: AppStrings.hintPassword,
                        errorText: snapshot.data)
                    );
                  },
                ),
              ),
              // * Register Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                          _viewModel.register();
                        }
                            : null,
                        child: Text(
                          AppStrings.register,
                          style: getMediumStyle(
                              color: ColorPallete.primaryWhite,
                              fontSize: FontSizeManager.s20),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // * Go to login screen when you have account
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppPadding.p8, horizontal: AppPadding.p28),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.alreadyHaveAccount,
                    style:
                    getMediumStyle(color: ColorPallete.primaryOrange),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
