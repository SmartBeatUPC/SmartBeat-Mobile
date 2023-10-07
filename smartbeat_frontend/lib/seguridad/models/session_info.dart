import 'package:smartbeat_frontend/seguridad/models/user.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';

class SessionInfo {
  User? dataUser;
  String? email;
  TypeUser? typeUser;
  bool? isDoctor;

  SessionInfo({
    required this.dataUser,
    required this.email,
    required this.typeUser,
    required this.isDoctor,
  });

  SessionInfo.empty();

  SessionInfo.fromLogin(Map<String, dynamic> data)
      : dataUser = User.from(data['dataUser']),
        isDoctor = data['isDoctor'],
        email = data['email'];

  SessionInfo.fromRegister(Map<String, dynamic> data)
      : dataUser = User.from(data['resource']);
}
