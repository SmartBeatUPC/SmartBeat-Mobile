import 'package:smartbeat_frontend/seguridad/models/user.dart';

class InfoApp {
  final User user;

  const InfoApp({
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
    };
  }
}
