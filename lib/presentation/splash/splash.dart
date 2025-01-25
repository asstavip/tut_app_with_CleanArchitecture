import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:flutter_advanced/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';

import '../../app/di.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences.isOnboardingViewed().then((isOnBoardingViewed) {
          if (isOnBoardingViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryOrange,
      body: Center(
        child: Image(
          image: const AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
