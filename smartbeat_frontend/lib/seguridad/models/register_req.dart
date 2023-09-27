import 'package:smartbeat_frontend/seguridad/models/registro_aditional_user_data.dart';
import 'package:smartbeat_frontend/seguridad/models/registro_inicial_req.dart';

class RegisterReq {
  RegistroInicialReq requestUserDto;
  RegistroAditonalUserData requestAditionalDataDto;

  RegisterReq({
    required this.requestUserDto,
    required this.requestAditionalDataDto,
  });

  Map<String, dynamic> toMap() => {
    'requestUserDto': requestUserDto.toMap(),
    'requestAditionalDataDto': requestAditionalDataDto.toMap(),
  };
}
