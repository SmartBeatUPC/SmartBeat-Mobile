import 'package:equatable/equatable.dart';

abstract class PredictionSaveState extends Equatable {
  const PredictionSaveState();

  @override
  List<Object?> get props => [];
}

class PredictionSaveInitial extends PredictionSaveState {}

class PredictionSaveLoading extends PredictionSaveState {}

class PredictionSaveSuccess extends PredictionSaveState {}

class PredictionSaveFailure extends PredictionSaveState {
  final String message;

  const PredictionSaveFailure(this.message);

  @override
  List<Object?> get props => [message];
}
