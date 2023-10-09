import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/home/models/prediction.dart';
import 'package:smartbeat_frontend/home/models/prediction_req.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/services/http_service.dart';

class PredictionService {
  static final PredictionService _instance =
      PredictionService._privateConstructor();

  static PredictionService get instance => _instance;

  PredictionService._privateConstructor();

  final _httpService = HttpService.instance;

  final String _apiUrlPatient = '${Environment.api}/suggestion/GPT-V2';
  final String _apiUrlDoctor = '${Environment.api}/suggestion/GPT-V2';

  Future<Prediction> getPredict(PredictionReq req, TypeUser typeUser) async {
    dynamic response = await _httpService.post(
      typeUser == TypeUser.doctor ? _apiUrlDoctor : _apiUrlPatient,
      body: req.toMap(),
    );
    return Prediction.from(response);
  }
}
