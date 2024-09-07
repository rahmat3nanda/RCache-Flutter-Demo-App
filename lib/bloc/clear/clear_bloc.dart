import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcache_demo_flutter/bloc/clear/clear_event.dart';
import 'package:rcache_demo_flutter/bloc/clear/clear_state.dart';
import 'package:rcache_demo_flutter/model/clear_type.dart';
import 'package:rcache_demo_flutter/model/log_model.dart';
import 'package:rcache_demo_flutter/utils/log_manager.dart';
import 'package:rcache_flutter/rcache.dart';

export 'package:rcache_demo_flutter/bloc/clear/clear_event.dart';
export 'package:rcache_demo_flutter/bloc/clear/clear_state.dart';

class ClearBloc extends Bloc<ClearEvent, ClearState> {
  ClearBloc(ClearInitialState super.initialState) {
    on<ClearDataEvent>(_data);
  }

  void _data(ClearDataEvent event, Emitter<ClearState> state) async {
    state(ClearInitialState());
    try {
      switch (event.type) {
        case ClearType.common:
          await RCache.common.clear();
        case ClearType.credentials:
          await RCache.credentials.clear();
        case ClearType.all:
          await RCache.clear();
      }

      await LogManager.instance.add(
        action: LogActionType.clear,
        value: "Clear ${event.type.value}",
      );
      state(const ClearDataSuccessState());
    } catch (e) {
      state(ClearDataFailedState(e.toString()));
    }
  }
}
