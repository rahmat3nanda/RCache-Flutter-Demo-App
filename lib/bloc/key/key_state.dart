import 'package:equatable/equatable.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';

abstract class KeyState extends Equatable {
  const KeyState();

  @override
  List<Object> get props => [];
}

class KeyInitialState extends KeyState {}

class KeyLoadSuccessState extends KeyState {
  final List<KeyModel> data;

  const KeyLoadSuccessState(this.data);
}

class KeyLoadFailedState extends KeyState {
  const KeyLoadFailedState();
}

class KeyAddSuccessState extends KeyState {
  final List<KeyModel> data;

  const KeyAddSuccessState(this.data);
}

class KeyAddFailedState extends KeyState {
  const KeyAddFailedState();
}

class KeyDeleteSuccessState extends KeyState {
  final List<KeyModel> data;

  const KeyDeleteSuccessState(this.data);
}

class KeyDeleteFailedState extends KeyState {
  const KeyDeleteFailedState();
}
