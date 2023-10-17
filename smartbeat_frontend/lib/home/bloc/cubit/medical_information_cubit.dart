import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_state.dart';
import 'package:smartbeat_frontend/home/forms/presion_form.dart';
import 'package:smartbeat_frontend/home/models/medical_information_ppg.dart';
import 'package:smartbeat_frontend/home/models/medical_information_req.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/models/req_medical_record.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class MedicalInformationCubit extends Cubit<MedicalInformationState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;
  PresionForm presionForm = PresionForm();

  MedicalInformationCubit() : super(MedicalInformationInitial());

  Future<void> registrarInformacionMedica(int medicalConsultationId,
      ReqMedicalInformation reqMedicalInformation) async {
    try {
      emit(MedicalInformationLoading());
      RequestMedicalRecord requestMedicalRecord =
          RequestMedicalRecord(recordDate: DateTime.now().toString());
      PresionReq presionReq = PresionReq.from(presionForm.rawValue);
      MedicalInformationReq req = MedicalInformationReq(
          requestMedicalRecordDto: requestMedicalRecord,
          reqMedicalInformation: reqMedicalInformation,
          reqPresion: presionReq);

      MedicalInformationPpg res = await _consultaMedicaService
          .createMedicalRecord(req, medicalConsultationId);

      emit(MedicalInformationSuccess(res, presionReq));
    } on ServiceException catch (e) {
      emit(MedicalInformationFailure(e.message));
    }
  }
}
