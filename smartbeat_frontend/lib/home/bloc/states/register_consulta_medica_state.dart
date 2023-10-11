import 'package:equatable/equatable.dart';

abstract class RegisterConsultaMedicaState extends Equatable {
  const RegisterConsultaMedicaState();

  @override
  List<Object?> get props => [];
}

class RegisterConsultaMedicaInitial extends RegisterConsultaMedicaState {}

class RegisterConsultaMedicaLoading extends RegisterConsultaMedicaState {}

class RegisterConsultaMedicaSuccess extends RegisterConsultaMedicaState {}

class RegisterConsultaMedicaFailure extends RegisterConsultaMedicaState {
  final String message;

  const RegisterConsultaMedicaFailure(this.message);

  @override
  List<Object?> get props => [message];
}
