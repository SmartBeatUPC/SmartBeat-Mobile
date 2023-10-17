import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/medical_information_ppg.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';

abstract class MedicalInformationState extends Equatable {
  const MedicalInformationState();

  @override
  List<Object?> get props => [];
}

class MedicalInformationInitial extends MedicalInformationState {}

class MedicalInformationLoading extends MedicalInformationState {}

class MedicalInformationSuccess extends MedicalInformationState {
  final PresionReq presionReq;
  final MedicalInformationPpg medicalInformationPpg;

  const MedicalInformationSuccess(this.medicalInformationPpg, this.presionReq);

  @override
  List<Object?> get props => [medicalInformationPpg, presionReq];
}

class MedicalInformationFailure extends MedicalInformationState {
  final String message;

  const MedicalInformationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
