import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/prediction_state.dart';
import 'package:smartbeat_frontend/home/models/medical_information.dart';
import 'package:smartbeat_frontend/home/models/prediction.dart';
import 'package:smartbeat_frontend/home/models/prediction_req.dart';
import 'package:smartbeat_frontend/home/services/prediction_service.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class PredictionCubit extends Cubit<PredictionState> {
  final PredictionService _predictionService = PredictionService.instance;

  PredictionCubit() : super(PredictionInitial());

  Future<void> predict(TypeUser typeUser) async {
    try {
      emit(PredictionLoading());
      //TODO Obtener informacion medica
      MedicalInformation medicalInformation = const MedicalInformation(
        height: '1.70',
        weight: '75.8',
        bmi: '26.2',
        sedentary: true,
        smoke: true,
        alcohol: false,
      );
      //TODO Obtener age, gender, pathologies
      PredictionReq predictionReq = PredictionReq(
        methodology: false,
        age: 22,
        gender: 'Masculino',
        medicalInformation: medicalInformation,
        pathologies: [],
      );
      Prediction prediction =
          await _predictionService.getPredict(predictionReq, typeUser);

      emit(PredictionSuccess(prediction));
    } on ServiceException catch (e) {
      emit(PredictionFailure(e.message));
    }
  }
}
