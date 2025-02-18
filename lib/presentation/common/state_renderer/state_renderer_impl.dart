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

class SuccessState extends FlowState {
  final String message;

  SuccessState(this.message);

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.popupSuccessState;
  }

  @override
  String getMessage() {
    return message;
  }
}

bool _isDialogShowing = false;

// lib/presentation/common/state_renderer/state_renderer_impl.dart
extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if ((this as LoadingState).stateRendererType ==
              StateRendererType.fullScreenLoadingState) {
            return StateRenderer(
              type: StateRendererType.fullScreenLoadingState,
              message: (this as LoadingState).getMessage(),
              retryActionFunction: retryActionFunction,
            );
          } else {
            showPopUp(
                context, StateRendererType.popupLoadingState, getMessage());
            return contentScreenWidget;
          }
        }
      case SuccessState:
        dismissDialog(context);
        showPopUp(context, StateRendererType.popupSuccessState,
            (this as SuccessState).message);
        return contentScreenWidget;
      case ErrorState:
        dismissDialog(context);
        showPopUp(context, StateRendererType.popupErrorState,
            (this as ErrorState).message);
        return contentScreenWidget;
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      default:
        return contentScreenWidget;
    }
  }

  void dismissDialog(BuildContext context, [Function? onDismissed]) {
    if (_isDialogShowing) {
      Navigator.of(context, rootNavigator: true).pop(true);
      _isDialogShowing = false;
      
      if (onDismissed != null) {
        onDismissed();
      }
    }
  }

  void showPopUp(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = ''}) {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          type: stateRendererType,
          message: message,
          title: title,
          retryActionFunction: () {},
        ),
      );
      _isDialogShowing = true;
    });
  }
}
