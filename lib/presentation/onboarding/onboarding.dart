import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced/domain/model.dart';
import 'package:flutter_advanced/presentation/onboarding/onboarding_view_model.dart';
import 'package:flutter_advanced/presentation/resources/routes_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/style_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_pallete.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  OnboardingViewModel _viewModel = OnboardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputs.sliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorPallete.primaryOrange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () => _,
            ),
          ),

          //indicators
          Row(
            children: [
              for (int i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i),
                ),
            ],
          ),

          //right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
              onTap: () => _goNext(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index) {
    if (_currentIndex == index) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc); //active
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc); //inactive
    }
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
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
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) => OnBoardingPage(
            sliderObject: sliderViewObject.sliderObject,
          ),
        ),
        bottomSheet: Container(
          color: ColorPallete.primaryWhite,
          height: AppSize.s100,
          child: Column(children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip,
                  style: getMediumStyle(color: ColorPallete.primaryOrange),
                ),
              ),
            ),
            _getBottomSheetWidget(),
          ]),
        ),
      );
    }
  }

  void _goPrevious() {
    _pageController.animateToPage(_getPreviousPage(),
        duration: const Duration(milliseconds: DurationConstant.s300),
        curve: Curves.bounceInOut);
  }

  void _goNext() {
    _pageController.animateToPage(_getNextPage(),
        duration: const Duration(milliseconds: DurationConstant.s300),
        curve: Curves.bounceInOut);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;
  const OnBoardingPage({required this.sliderObject, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}
