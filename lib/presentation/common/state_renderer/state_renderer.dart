import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/style_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

import '../../resources/color_pallete.dart';
import '../../resources/font_manager.dart';

enum StateRendererType {
  // Pop up state(dialog)
  popupLoadingState,
  popupErrorState,

  // Full screen state(full screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  // general state
  contentScreenState
}

class StateRenderer extends StatelessWidget {
  StateRendererType type;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({
    super.key,
    required this.type,
    this.message = AppStrings.loading,
    this.title = '',
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (type) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(context,[ _getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(context,[_getAnimatedImage(JsonAssets.error), _getMessage(message), _getRetryButton(AppStrings.ok, context)]);
      case StateRendererType.fullScreenLoadingState:
        return _getFullScreenLoadingState();
      case StateRendererType.fullScreenErrorState:
        return _getFullScreenErrorState(context);
      case StateRendererType.fullScreenEmptyState:
        return _getFullScreenEmptyState();
      case StateRendererType.contentScreenState:
        return Placeholder();
      }
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: children,
    );
  }

  Widget _getAnimatedImage(String name) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(name)
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
              color: ColorPallete.black, fontSize: FontSizeManager.s16),
        ),
      ),
    );
  }

  _getPopupDialog(BuildContext context,List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: ColorPallete.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPallete.primaryWhite,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(
            color: ColorPallete.transparentBlack,
          )]
        ),
        padding: EdgeInsets.all(AppPadding.p20),
        child: _getDialogContent(context, children),
      ),
    );
  }

  _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  _getFullScreenLoadingState() {
    return _getItemsColumn([_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
  }

  _getFullScreenErrorState(BuildContext context) {
    return _getItemsColumn([
      _getAnimatedImage(JsonAssets.error),
      _getMessage(message),
      _getRetryButton(AppStrings.retry, context)
    ]);
  }

  _getFullScreenEmptyState() {
    return _getItemsColumn([_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (type == StateRendererType.fullScreenErrorState) {
                // call to retry function
                retryActionFunction.call();
              } else {
                // close the dialog
                Navigator.pop(context);
              }
            },
            child: Text(
              buttonTitle,
              style: getMediumStyle(
                  color: ColorPallete.primaryWhite,
                  fontSize: FontSizeManager.s16),
            ),
          ),
        ),
      ),
    );
  }
}
