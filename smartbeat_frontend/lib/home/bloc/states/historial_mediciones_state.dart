import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';

abstract class HistorialMedicionesState extends Equatable {
  const HistorialMedicionesState();

  @override
  List<Object?> get props => [];
}

class HistorialMedicionesInitial extends HistorialMedicionesState {}

class HistorialMedicionesLoading extends HistorialMedicionesState {}

class HistorialMedicionesSuccess extends HistorialMedicionesState {
  final List<HistorialMedicion> listHistorialMedicion;

  const HistorialMedicionesSuccess(this.listHistorialMedicion);

  @override
  List<Object?> get props => [listHistorialMedicion];
}

class HistorialMedicionesFailure extends HistorialMedicionesState {
  final String message;

  const HistorialMedicionesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
