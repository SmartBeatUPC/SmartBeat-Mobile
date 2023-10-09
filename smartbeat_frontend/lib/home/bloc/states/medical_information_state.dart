import 'package:equatable/equatable.dart';

abstract class MedicalInformationState extends Equatable {
  const MedicalInformationState();

  @override
  List<Object?> get props => [];
}

class MedicalInformationInitial extends MedicalInformationState {}

class MedicalInformationLoading extends MedicalInformationState {}

class MedicalInformationSuccess extends MedicalInformationState {
  final int newMedicalInformationId;

  const MedicalInformationSuccess(this.newMedicalInformationId);

  @override
  List<Object?> get props => [newMedicalInformationId];
}

class MedicalInformationFailure extends MedicalInformationState {
  final String message;

  const MedicalInformationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
