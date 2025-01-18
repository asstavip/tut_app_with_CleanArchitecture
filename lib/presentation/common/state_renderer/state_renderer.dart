import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

enum StateRendererType {
  // Pop up state(dialog)
  popupLoadingState,
  popupErrorState,

  // Full screen state(full screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenSuccessState,
  // general state
  contentScreenState
}
class StateRenderer extends StatelessWidget {
   StateRendererType type;
   String message;
   String title;
   Function retryActionFunction;

  StateRenderer({super.key,
    required this.type,
    this.message = AppStrings.loading,
    this.title = '',
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
