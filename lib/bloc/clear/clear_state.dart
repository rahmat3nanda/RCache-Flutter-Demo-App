import 'package:equatable/equatable.dart';

abstract class ClearState extends Equatable {
  const ClearState();

  @override
  List<Object> get props => [];
}

class ClearInitialState extends ClearState {}

class ClearDataSuccessState extends ClearState {
  const ClearDataSuccessState();
}

class ClearDataFailedState extends ClearState {
  final String message;

  const ClearDataFailedState(this.message);
}
