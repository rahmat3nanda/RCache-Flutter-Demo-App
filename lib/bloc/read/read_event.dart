import 'package:equatable/equatable.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';

abstract class ReadEvent extends Equatable {
  const ReadEvent();

  @override
  List<Object> get props => [];
}

class ReadLoadEvent extends ReadEvent {
  const ReadLoadEvent();

  @override
  String toString() {
    return "ReadLoadEvent{}";
  }
}

class ReadDataEvent extends ReadEvent {
  final DataType dataType;
  final KeyModel key;
  final StorageType storageType;

  const ReadDataEvent({
    required this.dataType,
    required this.key,
    required this.storageType,
  });

  @override
  String toString() {
    return 'ReadDataEvent{dataType: $dataType, key: $key, storageType: $storageType}';
  }
}
