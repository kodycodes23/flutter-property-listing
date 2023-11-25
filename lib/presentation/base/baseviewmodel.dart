import 'dart:async';

import 'package:proptery/presentation/common/state_renderer/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called when viewmodel dies.

  Sink get inputState;
}

abstract mixin class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  StreamController<FlowState> _inputStateStreamController =
      BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }

// shared variables and functions that will be used through any view model.
}
