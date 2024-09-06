import 'package:equatable/equatable.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';

abstract class SaveEvent extends Equatable {
  const SaveEvent();

  @override
  List<Object> get props => [];
}

class SaveDataEvent extends SaveEvent {
  final DataType dataType;
  final KeyModel key;
  final StorageType storageType;
  final String value;

  const SaveDataEvent({
    required this.dataType,
    required this.key,
    required this.storageType,
    required this.value,
  });

  @override
  String toString() {
    return 'SaveDataEvent{dataType: $dataType, key: $key, storageType: $storageType, value: $value}';
  }
}
