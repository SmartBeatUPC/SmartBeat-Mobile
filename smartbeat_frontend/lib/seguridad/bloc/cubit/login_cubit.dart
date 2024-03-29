import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbeat_frontend/seguridad/bloc/state/login_state.dart';
import 'package:smartbeat_frontend/seguridad/forms/login_form.dart';
import 'package:smartbeat_frontend/seguridad/models/login_req.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';
import 'package:smartbeat_frontend/seguridad/models/user.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/seguridad/services/auth_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';
import 'package:smartbeat_frontend/shared/utils/app_constants.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService = AuthService.instance;

  final LoginForm loginForm = LoginForm();

  LoginCubit() : super(LoginInitial()) {
    updateFormWithRememberedForm();
  }

  Future<void> updateFormWithRememberedForm() async {
    emit(LoginLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formString = prefs.getString(AppConstants.keyRememberedForm);
    if (formString != null) {
      loginForm.patchValue(jsonDecode(formString));
    }
    emit(LoginInitial());
  }

  Future<void> setRememberedForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic>? rememberedForm = loginForm.rawValue;
    if (loginForm.recordarDatos.value! == false) {
      rememberedForm.remove('email');
      rememberedForm.remove('password');
    }
    bool savedForm = await prefs.setString(
        AppConstants.keyRememberedForm, jsonEncode(rememberedForm));
    if (!savedForm) {
      emit(const LoginFailure('No se ha podido guardar los datos de Login'));
    }
  }

  Future<void> login({isOnline = true}) async {
    try {
      await setRememberedForm();
      emit(LoginLoading());
      LoginReq loginReq = LoginReq.from(loginForm.rawValue);
      if (isOnline) {
        SessionInfo sessionInfo = await _authService.login(loginReq);
        sessionInfo.email = loginForm.email.value;
        emit(LoginSuccess(sessionInfo));
      } else {
        User dataUserPatient = User(
          id: 1,
          name: 'Arvin Kael',
          lastName: 'Garcia Godos',
          age: 23,
          dni: '7025421',
          gender: 'Masculino',
          phone: '999999999',
        );
        SessionInfo sessionInfo = SessionInfo(
          dataUser: dataUserPatient,
          email: "example@google.com",
          typeUser: TypeUser.patient,
          isDoctor: false,
        );
        emit(LoginSuccess(sessionInfo));
      }
    } on ServiceException catch (e) {
      emit(LoginFailure(e.message));
    }
  }
}
