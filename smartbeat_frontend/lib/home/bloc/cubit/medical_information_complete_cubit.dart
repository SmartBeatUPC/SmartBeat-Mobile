import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_complete_state.dart';
import 'package:smartbeat_frontend/home/models/medical_information_complete.dart';
import 'package:smartbeat_frontend/home/services/medical_information_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class MedicalInformationCompleteCubit
    extends Cubit<MedicalInformationCompleteState> {
  final MedicalInformationService _medicalInformationService =
      MedicalInformationService.instance;

  MedicalInformationCompleteCubit()
      : super(MedicalInformationCompleteInitial());

  Future<void> fetch(int medicalConsultationId) async {
    try {
      emit(MedicalInformationCompleteLoading());
      MedicalInformationComplete medicalInformationComplete =
          await _medicalInformationService
              .getMedicalInformationComplete(medicalConsultationId);
      emit(MedicalInformationCompleteSuccess(medicalInformationComplete));
    } on ServiceException catch (e) {
      emit(MedicalInformationCompleteFailure(e.message));
    }
  }
}
