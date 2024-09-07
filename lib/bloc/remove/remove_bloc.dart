import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcache_demo_flutter/bloc/remove/remove_event.dart';
import 'package:rcache_demo_flutter/bloc/remove/remove_state.dart';
import 'package:rcache_demo_flutter/model/log_model.dart';
import 'package:rcache_demo_flutter/utils/log_manager.dart';

export 'package:rcache_demo_flutter/bloc/remove/remove_event.dart';
export 'package:rcache_demo_flutter/bloc/remove/remove_state.dart';

class RemoveBloc extends Bloc<RemoveEvent, RemoveState> {
  RemoveBloc(RemoveInitialState super.initialState) {
    on<RemoveDataEvent>(_data);
  }

  void _data(RemoveDataEvent event, Emitter<RemoveState> state) async {
    state(RemoveInitialState());
    try {
      await event.storageType.rCache.remove(key: event.key.rCache);
      await LogManager.instance.add(
        action: LogActionType.remove,
        value:
            "\n-Key: ${event.key.name}\n-Storage Type: ${event.storageType.value}",
      );
      state(const RemoveDataSuccessState());
    } catch (e) {
      state(RemoveDataFailedState(e.toString()));
    }
  }
}
