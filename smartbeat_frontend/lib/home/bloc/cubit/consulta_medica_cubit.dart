import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/consulta_medica_state.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class ConsultaMedicaCubit extends Cubit<ConsultaMedicaState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;

  List<ConsultaMedica> listConsultaMedica = [];

  ConsultaMedicaCubit() : super(ConsultaMedicaInitial());

  Future<void> fetch(TypeUser typeUser, int userId) async {
    try {
      emit(ConsultaMedicaLoading());
      List<ConsultaMedica> list =
          await _consultaMedicaService.getListConsultaMedica(typeUser, userId);
      listConsultaMedica = list;
      emit(ConsultaMedicaSuccess(listConsultaMedica));
    } on ServiceException catch (e) {
      emit(ConsultaMedicaFailure(e.message));
    }
  }
}
