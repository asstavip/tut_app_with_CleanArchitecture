import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/constant.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer.dart';

import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// loading state (Pop up, Full screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {this.stateRendererType = StateRendererType.fullScreenLoadingState,
      this.message = AppStrings.loading});

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message ?? AppStrings.loading;
}

// error state (Pop up, Full screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

// content state
class ContentState extends FlowState {
  ContentState();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;

  @override
  String getMessage() => Constant.EMPTY;
}

// empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;

  @override
  String getMessage() => message;
}

bool _isDialogShowing = false;

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          if (!_isDialogShowing) {
            _isDialogShowing = true;
            showPopUp(context, getStateRendererType(), getMessage());
          }
          return contentScreenWidget;
        } else {
          return StateRenderer(
            type: getStateRendererType(),
            retryActionFunction: retryActionFunction,
            message: getMessage(),
          );
        }
      case ErrorState:
        _dismissDialog(context);
        if (!_isDialogShowing) {
          _isDialogShowing = true;
          showPopUp(context, getStateRendererType(), getMessage());
        }
        return contentScreenWidget;
      case ContentState:
        _dismissDialog(context);
        return contentScreenWidget;
      case EmptyState:
        return StateRenderer(
          type: getStateRendererType(),
          retryActionFunction: () {},
          message: getMessage(),
        );
      default:
        _dismissDialog(context);
        return contentScreenWidget;
    }
  }

  _dismissDialog(BuildContext context, [Function? onDismissed]) {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop(true);
      if (onDismissed != null) {
        onDismissed();
      }
    }
  }

  void showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => StateRenderer(
              type: stateRendererType,
              message: message,
              retryActionFunction: () {
                if (stateRendererType == StateRendererType.popupErrorState) {
                  _isDialogShowing = false;
                  Navigator.of(context, rootNavigator: true).pop(true);
                }
              },
            )));
    _isDialogShowing = true;
  }
}
