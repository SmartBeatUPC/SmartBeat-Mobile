import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/models/medical_information_req.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';
import 'package:smartbeat_frontend/shared/services/http_service.dart';

class ConsultaMedicaService {
  static final ConsultaMedicaService _instance =
      ConsultaMedicaService._privateConstructor();

  static ConsultaMedicaService get instance => _instance;

  ConsultaMedicaService._privateConstructor();

  final _httpService = HttpService.instance;

  final String _apiUrlPatient = '${Environment.api}/patient';
  final String _apiUrlDoctor = '${Environment.api}/medical-consultation';

  Future<List<ConsultaMedica>> getListConsultaMedica(
      TypeUser typeUser, int userId) async {
    String url =
        "${typeUser == TypeUser.doctor ? _apiUrlDoctor : _apiUrlPatient}/$userId/medical-consultations";

    dynamic response = await _httpService.get(url);

    if (response is Map<String, dynamic> &&
        response.containsKey("success") &&
        !response["success"]) {
      throw ServiceException(message: response["message"]);
    }

    if (response is List<dynamic>) {
      List<dynamic> consultasMedicasData = response;
      List<ConsultaMedica> consultaMedicaList =
      consultasMedicasData.map((map) => ConsultaMedica.from(map)).toList();
      return consultaMedicaList;
    } else {
      return [];
    }

  }

  Future<List<HistorialMedicion>> getListHistorialMediciones(
      int consultaMedicaId) async {
    String url = "$_apiUrlDoctor/$consultaMedicaId/ppgs";

    dynamic response = await _httpService.get(url);

    if (response is Map<String, dynamic> &&
        response.containsKey("success") &&
        !response["success"]) {
      throw ServiceException(message: response["message"]);
    }

    if (response is List<dynamic>) {
      List<HistorialMedicion> historialMedicionesList =
          response.map((map) => HistorialMedicion.from(map)).toList();
      return historialMedicionesList;
    } else {
      return [];
    }
  }

  Future<int> createMedicalRecord(
      MedicalInformationReq req, int medicalConsultationId) async {
    String url = "${_apiUrlDoctor}/$medicalConsultationId/medical-record";

    dynamic response = await _httpService.post(url, body: req.toMap());

    return response['newMedicalInformation']['id'];
  }


}
