import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/presion_ppg_state.dart';
import 'package:smartbeat_frontend/home/forms/presion_form.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/services/medical_information_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class PresionPpgCubit extends Cubit<PresionPpgState> {
  final MedicalInformationService _informationService =
      MedicalInformationService.instance;
  PresionForm presionForm = PresionForm();

  PresionPpgCubit() : super(PresionInitial());

  Future<void> registrarPresionPpg(ReqMedicalInformation reqMedicalInformation) async {
    try {
      emit(PresionLoading());
      /*
      PresionReq req = PresionReq.from(presionForm.rawValue);
      int newPresionPpg = await _informationService.registerPresionPpg(
          newMedicalInformationId, req);

      emit(PresionSuccess(newPresionPpg, req));
       */
    } on ServiceException catch (e) {
      emit(PresionFailure(e.message));
    }
  }
}
