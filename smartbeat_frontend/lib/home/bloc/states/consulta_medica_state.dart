import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';

abstract class ConsultaMedicaState extends Equatable {
  const ConsultaMedicaState();

  @override
  List<Object?> get props => [];
}

class ConsultaMedicaInitial extends ConsultaMedicaState {}

class ConsultaMedicaLoading extends ConsultaMedicaState {}

class ConsultaMedicaSuccess extends ConsultaMedicaState {
  final List<ConsultaMedica> listConsultaMedica;

  const ConsultaMedicaSuccess(this.listConsultaMedica);

  @override
  List<Object?> get props => [listConsultaMedica];
}

class ConsultaMedicaFailure extends ConsultaMedicaState {
  final String message;

  const ConsultaMedicaFailure(this.message);

  @override
  List<Object?> get props => [message];
}
