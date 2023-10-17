import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/home/models/medical_information_complete.dart';
import 'package:smartbeat_frontend/home/models/patologias_req.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';
import 'package:smartbeat_frontend/shared/services/http_service.dart';

class MedicalInformationService {
  static final MedicalInformationService _instance =
      MedicalInformationService._privateConstructor();

  static MedicalInformationService get instance => _instance;

  MedicalInformationService._privateConstructor();

  final _httpService = HttpService.instance;

  final String _apiUrl = '${Environment.api}/medical-information';

  Future<int> registerPresionPpg(
      int newMedicalInformationId, PresionReq req) async {
    final url = '$_apiUrl/$newMedicalInformationId/ppg';
    dynamic response = await _httpService.post(
      url,
      body: req.toMap(),
    );
    return response['resource']['id'];
  }

  Future<void> registerPatologias(
      int newMedicalInformationId, PatologiasReq req) async {
    final url = '$_apiUrl/$newMedicalInformationId/pathologies';
    await _httpService.post(
      url,
      body: req.toMap(),
    );
  }

  Future<MedicalInformationComplete> getMedicalInformationComplete(
      int newMedicalInformationId) async {
    final url = '$_apiUrl/$newMedicalInformationId/complete';
    dynamic response = await _httpService.get(
      url,
    );

    return MedicalInformationComplete.from(response);
  }
}
