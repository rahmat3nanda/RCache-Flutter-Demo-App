import 'package:equatable/equatable.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';

abstract class RemoveEvent extends Equatable {
  const RemoveEvent();

  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends RemoveEvent {
  final KeyModel key;
  final StorageType storageType;

  const RemoveDataEvent({
    required this.key,
    required this.storageType,
  });

  @override
  String toString() {
    return 'RemoveDataEvent{key: $key, storageType: $storageType}';
  }
}
