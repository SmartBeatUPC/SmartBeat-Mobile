import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/seguridad/bloc/state/register_state.dart';
import 'package:smartbeat_frontend/seguridad/forms/datos_personales_usuario_form.dart';
import 'package:smartbeat_frontend/seguridad/forms/registro_inicial_form.dart';
import 'package:smartbeat_frontend/seguridad/models/registro_aditional_user_data.dart';
import 'package:smartbeat_frontend/seguridad/models/register_req.dart';
import 'package:smartbeat_frontend/seguridad/models/registro_inicial_req.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/seguridad/services/auth_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthService _authService = AuthService.instance;
  late RegistroInicialForm registroForm;
  final DatosPersonalesUsuarioForm datosPersonalesUsuarioForm =
      DatosPersonalesUsuarioForm();

  RegisterCubit() : super(RegisterInitial());

  Future<void> register() async {
    try {
      emit(RegisterLoading());
      RegistroInicialReq requestUserDto =
          RegistroInicialReq.from(registroForm.rawValue);
      RegistroAditonalUserData requestAditionalDataDto =
          RegistroAditonalUserData.from(datosPersonalesUsuarioForm.rawValue);
      RegisterReq req = RegisterReq(
          requestUserDto: requestUserDto,
          requestAditionalDataDto: requestAditionalDataDto);
      TypeUser typeUser = requestAditionalDataDto.nationality != null
          ? TypeUser.patient
          : TypeUser.doctor;
      SessionInfo sessionInfo = await _authService.register(req, typeUser);
      emit(RegisterSuccess(sessionInfo, typeUser));
    } on ServiceException catch (e) {
      emit(RegisterFailure(e.message));
    }
  }
}
