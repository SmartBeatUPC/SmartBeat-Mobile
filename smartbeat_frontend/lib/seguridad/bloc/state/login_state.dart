import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final SessionInfo infoSession;

  const LoginSuccess(this.infoSession);

  @override
  List<Object?> get props => [infoSession];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}
