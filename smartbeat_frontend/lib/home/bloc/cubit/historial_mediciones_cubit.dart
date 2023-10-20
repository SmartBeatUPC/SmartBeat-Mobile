import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/historial_mediciones_state.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/consulta_medica_screen.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class HistorialMedicionesCubit extends Cubit<HistorialMedicionesState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;

  List<HistorialMedicion> listConsultaMedica = [];

  HistorialMedicionesCubit() : super(HistorialMedicionesInitial());

  Future<void> fetch(int medicalConsultationId, TypeFilter typeFilter) async {
    try {
      emit(HistorialMedicionesLoading());
      List<HistorialMedicion> list = await _consultaMedicaService
          .getListHistorialMediciones(medicalConsultationId, typeFilter);
      listConsultaMedica = list;
      emit(HistorialMedicionesSuccess(listConsultaMedica));
    } on ServiceException catch (e) {
      emit(HistorialMedicionesFailure(e.message));
    }
  }
}
