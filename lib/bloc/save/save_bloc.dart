import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rcache_demo_flutter/bloc/save/save_event.dart';
import 'package:rcache_demo_flutter/bloc/save/save_state.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/log_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';
import 'package:rcache_demo_flutter/utils/log_manager.dart';

export 'package:rcache_demo_flutter/bloc/save/save_event.dart';
export 'package:rcache_demo_flutter/bloc/save/save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  SaveBloc(SaveInitialState super.initialState) {
    on<SaveDataEvent>(_save);
  }

  void _save(SaveDataEvent event, Emitter<SaveState> state) async {
    state(SaveInitialState());
    try {
      switch (event.dataType) {
        case DataType.uint8List:
          await event.storageType.rCache.saveUint8List(
            Uint8List.fromList(event.value.codeUnits),
            key: event.key.rCache,
          );
          await _addToLog(
            event.dataType,
            event.key,
            event.storageType,
            event.value,
          );
        case DataType.string:
          await event.storageType.rCache.saveString(
            event.value,
            key: event.key.rCache,
          );
          await _addToLog(
            event.dataType,
            event.key,
            event.storageType,
            event.value,
          );
        case DataType.boolean:
          bool? value = event.value.boolValue;
          if (value == null) {
            state(const SaveDataFailedState("Invalid Boolean"));
            return;
          }
          await event.storageType.rCache.saveBool(
            value,
            key: event.key.rCache,
          );
          await _addToLog(
            event.dataType,
            event.key,
            event.storageType,
            event.value,
          );
        case DataType.integer:
          int? value = int.tryParse(event.value);
          if (value == null) {
            state(const SaveDataFailedState("Invalid Integer"));
            return;
          }
          await event.storageType.rCache.saveInteger(
            value,
            key: event.key.rCache,
          );
          await _addToLog(
            event.dataType,
            event.key,
            event.storageType,
            event.value,
          );
        case DataType.array:
        case DataType.map:
          state(const SaveDataFailedState("Not Implemented"));
          return;
        case DataType.double:
          double? value = double.tryParse(event.value);
          if (value == null) {
            state(const SaveDataFailedState("Invalid Double"));
            return;
          }
          await event.storageType.rCache.saveDouble(
            value,
            key: event.key.rCache,
          );
          await _addToLog(
            event.dataType,
            event.key,
            event.storageType,
            event.value,
          );
      }
      state(const SaveDataSuccessState());
    } catch (e) {
      state(SaveDataFailedState(e.toString()));
    }
  }

  Future<void> _addToLog(
    DataType dataType,
    KeyModel key,
    StorageType storageType,
    String value,
  ) async {
    await LogManager.instance.add(
      action: LogActionType.save,
      value:
          "\n-Data Type: ${dataType.value}\n-Key: ${key.name}\n-Storage Type: ${storageType.value}\n-Value: $value",
    );
  }
}

extension _StringBool on String {
  bool? get boolValue {
    if (toLowerCase() == "false") {
      return false;
    } else if (toLowerCase() == "true") {
      return true;
    }

    return null;
  }
}
