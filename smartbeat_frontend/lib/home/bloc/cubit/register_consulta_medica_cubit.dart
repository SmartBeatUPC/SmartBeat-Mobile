import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/register_consulta_medica_state.dart';
import 'package:smartbeat_frontend/home/forms/presion_form.dart';
import 'package:smartbeat_frontend/home/models/register_consulta_medica_req.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class RegisterConsultaMedicaCubit extends Cubit<RegisterConsultaMedicaState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;
  PresionForm presionForm = PresionForm();

  RegisterConsultaMedicaCubit() : super(RegisterConsultaMedicaInitial());

  Future<void> registrarPresionPpg(int patientId, int doctorId) async {
    try {
      emit(RegisterConsultaMedicaLoading());
      RegisterConsultaMedicaReq req =
          RegisterConsultaMedicaReq(doctorId: doctorId, patientId: patientId);
      await _consultaMedicaService.registerConsultaMedica(req);
      emit(RegisterConsultaMedicaSuccess());
    } on ServiceException catch (e) {
      emit(RegisterConsultaMedicaFailure(e.message));
    }
  }
}
