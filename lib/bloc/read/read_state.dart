import 'package:equatable/equatable.dart';

abstract class ReadState extends Equatable {
  const ReadState();

  @override
  List<Object> get props => [];
}

class ReadInitialState extends ReadState {}

class ReadDataSuccessState extends ReadState {
  final String? value;

  const ReadDataSuccessState(this.value);
}

class ReadDataFailedState extends ReadState {
  final String message;

  const ReadDataFailedState(this.message);
}
