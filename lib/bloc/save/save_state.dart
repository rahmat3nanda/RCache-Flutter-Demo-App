import 'package:equatable/equatable.dart';

abstract class SaveState extends Equatable {
  const SaveState();

  @override
  List<Object> get props => [];
}

class SaveInitialState extends SaveState {}

class SaveDataSuccessState extends SaveState {
  const SaveDataSuccessState();
}

class SaveDataFailedState extends SaveState {
  final String message;

  const SaveDataFailedState(this.message);
}
