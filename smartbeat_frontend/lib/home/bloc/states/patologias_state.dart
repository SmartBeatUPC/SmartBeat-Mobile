import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';

abstract class PatologiasState extends Equatable {
  const PatologiasState();

  @override
  List<Object?> get props => [];
}

class PatologiasInitial extends PatologiasState {}

class PatologiasLoading extends PatologiasState {}

class PatologiasSuccess extends PatologiasState {}

class PatologiasFailure extends PatologiasState {
  final String message;

  const PatologiasFailure(this.message);

  @override
  List<Object?> get props => [message];
}
