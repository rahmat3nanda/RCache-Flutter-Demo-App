import 'package:equatable/equatable.dart';

abstract class RemoveState extends Equatable {
  const RemoveState();

  @override
  List<Object> get props => [];
}

class RemoveInitialState extends RemoveState {}

class RemoveDataSuccessState extends RemoveState {
  const RemoveDataSuccessState();
}

class RemoveDataFailedState extends RemoveState {
  final String message;

  const RemoveDataFailedState(this.message);
}
