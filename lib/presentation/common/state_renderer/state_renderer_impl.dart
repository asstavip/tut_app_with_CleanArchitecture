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

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState _:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          // show pop up loading
          showPopUp(context, getStateRendererType(), getMessage());
          // show content ui of the screen
          return contentScreenWidget;
        } else {
          // full screen loading state
          return StateRenderer(
            type: getStateRendererType(),
            retryActionFunction: retryActionFunction,
            message: getMessage(),
          );
        }
      case ErrorState _:
        _dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          // show pop up error
          showPopUp(context, getStateRendererType(), getMessage());
          // show content ui of the screen
          return contentScreenWidget;
        } else {
          // full screen error state
          return StateRenderer(
            type: getStateRendererType(),
            retryActionFunction: retryActionFunction,
          );
        }
      case ContentState _:
        _dismissDialog(context);
        return contentScreenWidget;
      case EmptyState _:
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

  _isCurrentContainDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  _dismissDialog(BuildContext context) {
    if (_isCurrentContainDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StateRenderer(
              type: stateRendererType,
              message: message,
              retryActionFunction: () {},
            );
          },
        );
      });
    }
  }
}
