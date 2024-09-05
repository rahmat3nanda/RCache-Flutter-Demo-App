import 'package:equatable/equatable.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';

abstract class KeyEvent extends Equatable {
  const KeyEvent();

  @override
  List<Object> get props => [];
}

class KeyLoadEvent extends KeyEvent {
  const KeyLoadEvent();

  @override
  String toString() {
    return "KeyLoadEvent{}";
  }
}

class KeyAddEvent extends KeyEvent {
  final String name;

  const KeyAddEvent(this.name);

  @override
  String toString() {
    return 'KeyAddEvent{name: $name}';
  }
}

class KeyDeleteEvent extends KeyEvent {
  final KeyModel item;

  const KeyDeleteEvent(this.item);

  @override
  String toString() {
    return 'KeyDeleteEvent{item: $item}';
  }
}
