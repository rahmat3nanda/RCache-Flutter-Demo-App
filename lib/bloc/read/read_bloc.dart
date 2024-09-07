import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcache_demo_flutter/bloc/read/read_event.dart';
import 'package:rcache_demo_flutter/bloc/read/read_state.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/log_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';
import 'package:rcache_demo_flutter/utils/log_manager.dart';

export 'package:rcache_demo_flutter/bloc/read/read_event.dart';
export 'package:rcache_demo_flutter/bloc/read/read_state.dart';

class ReadBloc extends Bloc<ReadEvent, ReadState> {
  ReadBloc(ReadInitialState super.initialState) {
    on<ReadDataEvent>(_data);
  }

  void _data(ReadDataEvent event, Emitter<ReadState> state) async {
    state(ReadInitialState());
    try {
      String? result;
      switch (event.dataType) {
        case DataType.uint8List:
          Uint8List? value = await event.storageType.rCache.readUint8List(
            key: event.key.rCache,
          );
          if (value != null) {
            result = String.fromCharCodes(value);
          }
        case DataType.string:
          result = await event.storageType.rCache.readString(
            key: event.key.rCache,
          );
        case DataType.boolean:
          bool? value = await event.storageType.rCache.readBool(
            key: event.key.rCache,
          );
          result = value?.toString();
        case DataType.integer:
          int? value = await event.storageType.rCache.readInteger(
            key: event.key.rCache,
          );
          log("$value");
          result = value?.toString();
        case DataType.array:
        case DataType.map:
          state(const ReadDataFailedState("Not Implemented"));
          return;
        case DataType.double:
          double? value = await event.storageType.rCache.readDouble(
            key: event.key.rCache,
          );
          result = value?.toString();
      }
      _addToLog(event.dataType, event.key, event.storageType, result ?? "null");
      state(ReadDataSuccessState(result));
    } catch (e) {
      state(ReadDataFailedState(e.toString()));
    }
  }

  Future<void> _addToLog(
    DataType dataType,
    KeyModel key,
    StorageType storageType,
    String value,
  ) async {
    await LogManager.instance.add(
      action: LogActionType.read,
      value:
          "\n-Data Type: ${dataType.value}\n-Key: ${key.name}\n-Storage Type: ${storageType.value}\n-Value: $value",
    );
  }
}
