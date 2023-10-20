import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/last_medical_information.dart';

abstract class LastMedicalInformationState extends Equatable {
  const LastMedicalInformationState();

  @override
  List<Object?> get props => [];
}

class LastMedicalInformationInitial extends LastMedicalInformationState {}

class LastMedicalInformationLoading extends LastMedicalInformationState {}

class LastMedicalInformationSuccess extends LastMedicalInformationState {
  final LastMedicalInformation lastMedicalInformation;

  const LastMedicalInformationSuccess(this.lastMedicalInformation);

  @override
  List<Object?> get props => [lastMedicalInformation];
}

class LastMedicalInformationFailure extends LastMedicalInformationState {
  final String message;

  const LastMedicalInformationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
