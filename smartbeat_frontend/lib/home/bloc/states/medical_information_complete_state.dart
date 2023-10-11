import 'package:equatable/equatable.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/models/medical_information_complete.dart';

abstract class MedicalInformationCompleteState extends Equatable {
  const MedicalInformationCompleteState();

  @override
  List<Object?> get props => [];
}

class MedicalInformationCompleteInitial
    extends MedicalInformationCompleteState {}

class MedicalInformationCompleteLoading
    extends MedicalInformationCompleteState {}

class MedicalInformationCompleteSuccess
    extends MedicalInformationCompleteState {
  final MedicalInformationComplete medicalInformationComplete;

  const MedicalInformationCompleteSuccess(this.medicalInformationComplete);

  @override
  List<Object?> get props => [medicalInformationComplete];
}

class MedicalInformationCompleteFailure
    extends MedicalInformationCompleteState {
  final String message;

  const MedicalInformationCompleteFailure(this.message);

  @override
  List<Object?> get props => [message];
}
