import 'package:equatable/equatable.dart';

abstract class InfoAppState extends Equatable {
  const InfoAppState();

  @override
  List<Object?> get props => [];
}

class InfoAppInitial extends InfoAppState {}

class InfoAppLoading extends InfoAppState {}

class InfoAppSuccess extends InfoAppState {}

class SigoutInfoAppSuccess extends InfoAppState {}

class InfoAppFailure extends InfoAppState {
  final String message;

  const InfoAppFailure(this.message);

  @override
  List<Object?> get props => [message];
}
