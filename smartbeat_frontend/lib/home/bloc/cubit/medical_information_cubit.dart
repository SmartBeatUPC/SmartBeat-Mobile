import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_state.dart';
import 'package:smartbeat_frontend/home/forms/info_medica_form.dart';
import 'package:smartbeat_frontend/home/models/medical_information_req.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/models/req_medical_record.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class MedicalInformationCubit extends Cubit<MedicalInformationState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;
  InfoMedicaForm infoMedicaForm = InfoMedicaForm();

  MedicalInformationCubit() : super(MedicalInformationInitial());

  Future<void> registrarInformacionMedica(int medicalConsultationId) async {
    try {
      emit(MedicalInformationLoading());
      RequestMedicalRecord requestMedicalRecord =
          RequestMedicalRecord(recordDate: DateTime.now().toString());
      ReqMedicalInformation reqMedicalInformation =
          ReqMedicalInformation.from(infoMedicaForm.rawValue);
      MedicalInformationReq req = MedicalInformationReq(
          requestMedicalRecordDto: requestMedicalRecord,
          reqMedicalInformation: reqMedicalInformation);

      int newMedicalInformationId =
          await _consultaMedicaService.createMedicalRecord(req, medicalConsultationId);

      emit(MedicalInformationSuccess(newMedicalInformationId));
    } on ServiceException catch (e) {
      emit(MedicalInformationFailure(e.message));
    }
  }
}
