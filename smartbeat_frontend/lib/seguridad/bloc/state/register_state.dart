import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final SessionInfo infoSession;
  final TypeUser typeUser;

  const RegisterSuccess(this.infoSession, this.typeUser);

  @override
  List<Object?> get props => [infoSession];
}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}
