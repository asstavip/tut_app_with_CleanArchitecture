import 'package:easy_localization/easy_localization.dart';
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
  contentScreenState,
  popupSuccessState
}

class StateRenderer extends StatelessWidget {
  final StateRendererType type;
  final String message;
  final String title;
  final Function? retryActionFunction;

   const StateRenderer({
    super.key,
    required this.type,
    required this.message,
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
        return _getPopupDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getFullScreenLoadingState();
      case StateRendererType.fullScreenErrorState:
        return _getFullScreenErrorState(context);
      case StateRendererType.fullScreenEmptyState:
        return _getFullScreenEmptyState();
      case StateRendererType.contentScreenState:
        return Placeholder();
      case StateRendererType.popupSuccessState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context)
        ]);
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
        height: AppSize.s100, width: AppSize.s100, child: Lottie.asset(name));
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

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
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
            boxShadow: const [
              BoxShadow(
                color: ColorPallete.transparentBlack,
              )
            ]),
        padding: EdgeInsets.all(AppPadding.p20),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getFullScreenLoadingState() {
    return _getItemsColumn(
        [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
  }

  Widget _getFullScreenErrorState(BuildContext context) {
    return _getItemsColumn([
      _getAnimatedImage(JsonAssets.error),
      _getMessage(message),
      _getRetryButton(AppStrings.retry.tr(), context)
    ]);
  }

  Widget _getFullScreenEmptyState() {
    return _getItemsColumn(
        [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (StateRendererType == StateRendererType.fullScreenErrorState) {
                retryActionFunction?.call();
              } else {
                Navigator.of(context).pop();
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
