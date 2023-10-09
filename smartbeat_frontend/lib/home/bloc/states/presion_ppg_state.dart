import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';

abstract class PresionPpgState extends Equatable {
  const PresionPpgState();

  @override
  List<Object?> get props => [];
}

class PresionInitial extends PresionPpgState {}

class PresionLoading extends PresionPpgState {}

class PresionSuccess extends PresionPpgState {
  final int ppgPresionId;
  final PresionReq presionReq;

  const PresionSuccess(this.ppgPresionId, this.presionReq);

  @override
  List<Object?> get props => [ppgPresionId];
}

class PresionFailure extends PresionPpgState {
  final String message;

  const PresionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
