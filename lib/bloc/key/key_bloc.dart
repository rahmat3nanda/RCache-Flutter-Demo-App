import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcache_demo_flutter/app_rcache_key.dart';
import 'package:rcache_demo_flutter/bloc/key/key_event.dart';
import 'package:rcache_demo_flutter/bloc/key/key_state.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/utils/log_manager.dart';
import 'package:rcache_flutter/rcache.dart';

export 'package:rcache_demo_flutter/bloc/key/key_event.dart';
export 'package:rcache_demo_flutter/bloc/key/key_state.dart';

class KeyBloc extends Bloc<KeyEvent, KeyState> {
  List<KeyModel> _data = [];

  KeyBloc(KeyInitialState super.initialState) {
    on<KeyLoadEvent>(_load);
    on<KeyAddEvent>(_add);
    on<KeyDeleteEvent>(_delete);
  }

  void _load(KeyLoadEvent event, Emitter<KeyState> state) async {
    state(KeyInitialState());
    try {
      List<dynamic>? keys = await RCache.common.readArray(
        key: AppRCacheKey.savedKeys,
      );
      if (keys != null) {
        _data = keys.map((e) => KeyModel(name: e as String)).toList();
      }
      state(KeyLoadSuccessState(_data));
    } catch (e) {
      state(const KeyLoadFailedState());
    }
  }

  void _add(KeyAddEvent event, Emitter<KeyState> state) async {
    state(KeyInitialState());
    try {
      _data.add(KeyModel(name: event.name));
      await RCache.common.saveArray(
        _data.map((e) => e.name).toList(),
        key: AppRCacheKey.savedKeys,
      );
      await LogManager.instance.add(
        action: LogActionType.addKey,
        value: event.name,
      );
      state(KeyAddSuccessState(_data));
    } catch (e) {
      state(const KeyAddFailedState());
    }
  }

  void _delete(KeyDeleteEvent event, Emitter<KeyState> state) async {
    state(KeyInitialState());
    try {
      await LogManager.instance.add(
        action: LogActionType.removeKey,
        value: event.item.name,
      );
      _data.remove(event.item);
      await RCache.common.saveArray(
        _data.map((e) => e.name).toList(),
        key: AppRCacheKey.savedKeys,
      );
      state(KeyDeleteSuccessState(_data));
    } catch (e) {
      state(const KeyDeleteFailedState());
    }
  }
}
