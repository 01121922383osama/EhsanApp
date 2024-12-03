import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('bloc: ${bloc.state} event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('bloc: ${bloc.state} error: $error StackTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('bloc: ${bloc.state} currentState: ${change.currentState} nextState: ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('bloc: ${bloc.state} transition: ${transition.event} currentState: ${transition.currentState} nextState: ${transition.nextState}');
  }
}
