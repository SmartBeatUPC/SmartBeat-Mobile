import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/last_medical_information_state.dart';
import 'package:smartbeat_frontend/home/models/last_medical_information.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class LastMedicalInformationCubit extends Cubit<LastMedicalInformationState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;

  LastMedicalInformationCubit() : super(LastMedicalInformationInitial());

  Future<void> fetch(int medicalConsultationId) async {
    try {
      emit(LastMedicalInformationLoading());
      LastMedicalInformation res = await _consultaMedicaService
          .getLastMedicalInformation(medicalConsultationId);
      emit(LastMedicalInformationSuccess(res));
    } on ServiceException catch (e) {
      emit(LastMedicalInformationFailure(e.message));
    }
  }
}
