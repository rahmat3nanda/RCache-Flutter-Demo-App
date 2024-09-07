import 'package:equatable/equatable.dart';
import 'package:rcache_demo_flutter/model/clear_type.dart';

abstract class ClearEvent extends Equatable {
  const ClearEvent();

  @override
  List<Object> get props => [];
}

class ClearDataEvent extends ClearEvent {
  final ClearType type;

  const ClearDataEvent(this.type);

  @override
  String toString() {
    return 'ClearDataEvent{type: $type}';
  }
}
