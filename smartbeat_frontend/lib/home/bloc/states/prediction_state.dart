import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/prediction.dart';

abstract class PredictionState extends Equatable {
  const PredictionState();

  @override
  List<Object?> get props => [];
}

class PredictionInitial extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionSuccess extends PredictionState {
  final Prediction prediction;

  const PredictionSuccess(this.prediction);

  @override
  List<Object?> get props => [prediction];
}

class PredictionFailure extends PredictionState {
  final String message;

  const PredictionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
