import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/prediction_save_state.dart';
import 'package:smartbeat_frontend/home/services/prediction_service.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class PredictionSaveCubit extends Cubit<PredictionSaveState> {
  final PredictionService _predictionService = PredictionService.instance;

  PredictionSaveCubit() : super(PredictionSaveInitial());

  Future<void> savePrediction(
      TypeUser typeUser, String textPrediction, int medicalRecordId) async {
    try {
      emit(PredictionSaveLoading());
      await _predictionService.savePrediction(
          medicalRecordId, typeUser, textPrediction);
      emit(PredictionSaveSuccess());
    } on ServiceException catch (e) {
      emit(PredictionSaveFailure(e.message));
    }
  }
}
