import 'package:equatable/equatable.dart';

abstract class RegisterDiagnosticState extends Equatable {
  const RegisterDiagnosticState();

  @override
  List<Object?> get props => [];
}

class RegisterDiagnosticInitial extends RegisterDiagnosticState {}

class RegisterDiagnosticLoading extends RegisterDiagnosticState {}

class RegisterDiagnosticSuccess extends RegisterDiagnosticState {}

class RegisterDiagnosticFailure extends RegisterDiagnosticState {
  final String message;

  const RegisterDiagnosticFailure(this.message);

  @override
  List<Object?> get props => [message];
}
