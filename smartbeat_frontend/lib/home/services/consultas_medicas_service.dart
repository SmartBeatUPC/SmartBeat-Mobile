import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
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
    List<dynamic> consultasMedicasData = response as List<dynamic>;
    List<ConsultaMedica> consultaMedicaList =
        consultasMedicasData.map((map) => ConsultaMedica.from(map)).toList();
    return consultaMedicaList;
  }

  Future<List<HistorialMedicion>> getListHistorialMediciones(
      int consultaMedicaId) async {
    String url = "$_apiUrlDoctor/$consultaMedicaId/ppgs";

    dynamic response = await _httpService.get(url);
    List<dynamic> historialMedicionesData = response as List<dynamic>;
    List<HistorialMedicion> historialMedicionesList =
        historialMedicionesData.map((map) => HistorialMedicion.from(map)).toList();
    return historialMedicionesList;
  }
}
