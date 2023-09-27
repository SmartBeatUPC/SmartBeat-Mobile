import 'package:smartbeat_frontend/config/environment/environment.dart';
import 'package:smartbeat_frontend/seguridad/models/login_req.dart';
import 'package:smartbeat_frontend/seguridad/models/register_req.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/services/http_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._privateConstructor();

  static AuthService get instance => _instance;

  AuthService._privateConstructor();

  final _httpService = HttpService.instance;

  final String _apiUrl = '${Environment.api}/user';

  Future<SessionInfo> login(LoginReq loginReq) async {
    String url = '$_apiUrl/loginSession';
    dynamic response = await _httpService.post(
      url,
      body: loginReq.toMap(),
    );
    return SessionInfo.fromLogin(response);
  }

  Future<SessionInfo> register(RegisterReq req, TypeUser typeUser) async {
    String url = '$_apiUrl/${typeUser.name}';
    dynamic response = await _httpService.post(
      url,
      body: req.toMap(),
    );
    return SessionInfo.fromRegister(response);
  }
}
