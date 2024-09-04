import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class Observer extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log("$bloc $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log("$transition");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log("$bloc $error");
    log(stackTrace.toString());
    super.onError(bloc, error, stackTrace);
  }
}
