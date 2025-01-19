import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/login/login_view_model.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/style_manager.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // using get_it to get the instance of the view model
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryWhite,
      body: StreamBuilder(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(), _viewModel.login()) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        color: ColorPallete.primaryWhite,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Center(
                  child: Image(
                    image: const AssetImage(ImageAssets.splashLogo),
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.isEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        style: TextStyle(color: ColorPallete.primaryGray),
                        cursorColor: ColorPallete.primaryOrange,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: ColorPallete.primaryGray),
                          focusColor: ColorPallete.primaryOrange,
                          labelText: AppStrings.email,
                          hintText: AppStrings.hintEmail,
                          errorText: snapshot.data == true
                              ? null
                              : AppStrings.emailError,
                          filled: true,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.isPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        style: TextStyle(color: ColorPallete.primaryGray),
                        cursorColor: ColorPallete.primaryOrange,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: ColorPallete.primaryGray),
                          focusColor: ColorPallete.primaryOrange,
                          labelText: AppStrings.password,
                          hintText: AppStrings.hintPassword,
                          errorText: snapshot.data == true
                              ? null
                              : AppStrings.passwordError,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.isPasswordValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: snapshot.data == true
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: Text(
                            AppStrings.login,
                            style: getMediumStyle(
                                color: ColorPallete.primaryWhite,
                                fontSize: FontSizeManager.s20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppPadding.p8, horizontal: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style:
                              getMediumStyle(color: ColorPallete.primaryOrange),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.registerText,
                          style:
                              getMediumStyle(color: ColorPallete.primaryOrange),
                        ),
                      ),
                    ],
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
