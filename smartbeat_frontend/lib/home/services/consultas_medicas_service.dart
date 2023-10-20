import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/models/diagnostic.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/models/last_medical_information.dart';
import 'package:smartbeat_frontend/home/models/medical_information_ppg.dart';
import 'package:smartbeat_frontend/home/models/medical_information_req.dart';
import 'package:smartbeat_frontend/home/models/register_consulta_medica_req.dart';
import 'package:smartbeat_frontend/home/models/register_diagnostic_req.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/consulta_medica_screen.dart';
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

    if (response['medicalConsultations'] is List<dynamic>) {
      List<dynamic> consultasMedicasData = response['medicalConsultations'];
      List<ConsultaMedica> consultaMedicaList = consultasMedicasData
          .map((map) => ConsultaMedica.from(map, typeUser))
          .toList();
      return consultaMedicaList;
    } else {
      throw ServiceException(
          message:
              'medicalConsultations no puede ser parseado a una List<dynamic>');
    }
  }

  String getNumberFilterOfTypeFilter(TypeFilter typeFilter) {
    if (typeFilter == TypeFilter.Todos) {
      return '1';
    }
    if (typeFilter == TypeFilter.Hoy) {
      return '2';
    }
    if (typeFilter == TypeFilter.Diagnostico) {
      return '3';
    }
    return '1';
  }

  Future<List<HistorialMedicion>> getListHistorialMediciones(
      int consultaMedicaId, TypeFilter typeFilter) async {
    String url =
        "$_apiUrlDoctor/$consultaMedicaId/ppgs/${getNumberFilterOfTypeFilter(typeFilter)}";

    dynamic response = await _httpService.get(url);

    if (response['ppgs'] is List<dynamic>) {
      List<dynamic> historialMedicionesListMap = response['ppgs'];

      List<HistorialMedicion> historialMedicionesList =
          historialMedicionesListMap
              .map((e) => HistorialMedicion.from(e))
              .toList();
      return historialMedicionesList;
    } else {
      return [];
    }
  }

  Future<MedicalInformationPpg> createMedicalRecord(
      MedicalInformationReq req, int medicalConsultationId) async {
    String url = "${_apiUrlDoctor}/$medicalConsultationId/medical-record";

    dynamic response = await _httpService.post(url, body: req.toMap());

    return MedicalInformationPpg.from(response);
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

  Future<LastMedicalInformation> getLastMedicalInformation(
      int medicalInformationId) async {
    String url =
        "${Environment.api}/medical-consultation/$medicalInformationId/medical-information/last";

    dynamic response = await _httpService.get(url);

    return LastMedicalInformation.from(response);
  }
}
