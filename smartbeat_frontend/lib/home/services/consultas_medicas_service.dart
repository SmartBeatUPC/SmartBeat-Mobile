import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/models/diagnostic.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/models/medical_information_req.dart';
import 'package:smartbeat_frontend/home/models/register_consulta_medica_req.dart';
import 'package:smartbeat_frontend/home/models/register_diagnostic_req.dart';
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
        "${Environment.api}/${typeUser.name}/$userId/medical-consultations";

    dynamic response = await _httpService.get(url);

    if (response is Map<String, dynamic> &&
        response.containsKey("success") &&
        !response["success"]) {
      throw ServiceException(message: response["message"]);
    }

    if (response is List<dynamic>) {
      List<dynamic> consultasMedicasData = response;
      List<ConsultaMedica> consultaMedicaList = consultasMedicasData
          .map((map) => ConsultaMedica.from(map, typeUser))
          .toList();
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

  Future<void> createDiagnostic(
      RegisterDiagnosticReq req, int medicalRecordId) async {
    String url =
        "${Environment.api}/medical-record/$medicalRecordId/diagnostic";

    dynamic response = await _httpService.post(url, body: req.toMap());
    if (response is Map<String, dynamic> &&
        response.containsKey("success") &&
        !response["success"]) {
      throw ServiceException(message: response["message"]);
    }
  }

  Future<void> registerConsultaMedica(RegisterConsultaMedicaReq req) async {
    await _httpService.post(_apiUrlDoctor, body: req.toMap());
  }

  Future<Diagnostic> getDiagnosticByMedicalRecordId(int medicalRecordId) async {
    String url =
        "${Environment.api}/medical-record/$medicalRecordId/diagnostic";

    dynamic response = await _httpService.get(url);
    if (response is Map<String, dynamic> &&
        response.containsKey("success") &&
        !response["success"]) {
      throw ServiceException(message: response["message"]);
    }
    return Diagnostic.from(response);
  }
}
