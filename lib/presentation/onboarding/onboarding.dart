import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/resources/style_manager.dart';

import '../resources/color_pallete.dart';
import '../resources/font_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryOrange,
      body: Center(child: Text('Welcome to Onboarding'),),
    );
  }
}
