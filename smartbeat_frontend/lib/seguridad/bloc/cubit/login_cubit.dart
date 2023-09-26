import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/seguridad/bloc/state/login_state.dart';
import 'package:smartbeat_frontend/seguridad/forms/login_form.dart';
import 'package:smartbeat_frontend/seguridad/models/login_req.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';
import 'package:smartbeat_frontend/seguridad/services/auth_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService = AuthService.instance;

  final LoginForm loginForm = LoginForm();

  LoginCubit() : super(LoginInitial());

  Future<void> login() async {
    try {
      emit(LoginLoading());
      LoginReq loginReq = LoginReq.from(loginForm.rawValue);
      SessionInfo sessionInfo = await _authService.login(loginReq);
      emit(LoginSuccess(sessionInfo));
    } on ServiceException catch (e) {
      emit(LoginFailure(e.message));
    }
  }
}
