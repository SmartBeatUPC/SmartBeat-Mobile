import 'package:smartbeat_frontend/seguridad/models/user.dart';

class SessionInfo {
  User? dataUser;
  String? email;

  SessionInfo({
    required this.dataUser,
    required this.email,
  });

  SessionInfo.empty();

  SessionInfo.from(Map<String, dynamic> data)
      : dataUser = User.from(data['dataUser']),
        email = data['email'];
}