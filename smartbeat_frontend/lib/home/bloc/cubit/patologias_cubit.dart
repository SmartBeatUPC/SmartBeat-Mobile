import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/patologias_state.dart';
import 'package:smartbeat_frontend/home/models/Patologia.dart';
import 'package:smartbeat_frontend/home/models/patologias_req.dart';
import 'package:smartbeat_frontend/home/services/medical_information_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class PatologiasCubit extends Cubit<PatologiasState> {
  final MedicalInformationService _informationService =
      MedicalInformationService.instance;

  PatologiasCubit() : super(PatologiasInitial());

  Future<void> registrarPatologia(
      int newMedicalInformationId, List<Patologia> list) async {
    try {
      emit(PatologiasLoading());
      PatologiasReq req = PatologiasReq(patologias: list);
      await _informationService.registerPatologias(
          newMedicalInformationId, req);

      emit(PatologiasSuccess());
    } on ServiceException catch (e) {
      emit(PatologiasFailure(e.message));
    }
  }
}
