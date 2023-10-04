import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/seguridad/bloc/state/login_state.dart';
import 'package:smartbeat_frontend/seguridad/forms/login_form.dart';
import 'package:smartbeat_frontend/seguridad/models/login_req.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';
import 'package:smartbeat_frontend/seguridad/models/user.dart';
import 'package:smartbeat_frontend/seguridad/services/auth_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService = AuthService.instance;

  final LoginForm loginForm = LoginForm();

  LoginCubit() : super(LoginInitial());

  Future<void> login({isOnline = true}) async {
    try {
      emit(LoginLoading());
      LoginReq loginReq = LoginReq.from(loginForm.rawValue);
      if (isOnline) {
        SessionInfo sessionInfo = await _authService.login(loginReq);
        emit(LoginSuccess(sessionInfo));
      } else {
        User dataUserPatient = User(id: 1,
            name: 'Arvin Kael',
            lastName: 'Garcia Godos',
            age: 23,
            dni: '7025421',
            gender: 'Masculino',
            phone: '999999999',
        );
        SessionInfo sessionInfo = SessionInfo(
            dataUser: dataUserPatient, email: "example@google.com");
        emit(LoginSuccess(sessionInfo));
      }
    } on ServiceException catch (e) {
      emit(LoginFailure(e.message));
    }
  }
}
