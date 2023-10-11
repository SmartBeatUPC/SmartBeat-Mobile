import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/models/diagnostic.dart';

abstract class DiagnosticState extends Equatable {
  const DiagnosticState();

  @override
  List<Object?> get props => [];
}

class DiagnosticInitial extends DiagnosticState {}

class DiagnosticLoading extends DiagnosticState {}

class DiagnosticSuccess extends DiagnosticState {
  final Diagnostic diagnostic;

  const DiagnosticSuccess(this.diagnostic);

  @override
  List<Object?> get props => [diagnostic];
}

class DiagnosticFailure extends DiagnosticState {
  final String message;

  const DiagnosticFailure(this.message);

  @override
  List<Object?> get props => [message];
}
