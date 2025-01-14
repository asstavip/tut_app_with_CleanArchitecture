import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/login/login_view_model.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

import '../resources/assets_manager.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginViewModel _viewModel = LoginViewModel(null); // TODO: remove null

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
    return const Placeholder();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          errorText: snapshot.data == false
                              ? "Please enter a valid email"
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
