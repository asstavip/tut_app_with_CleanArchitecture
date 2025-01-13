abstract class BaseViewModel implements BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and functions that will be used trough any view model
}


abstract class BaseViewModelInputs {
  // events that will trigger the view model actions
  void start(); // will be called while init . of view model
  void dispose(); // will be called while deinit . of view model
}

abstract class BaseViewModelOutputs {
  // events that will trigger the view to update
}
