import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/register_diagnostic_state.dart';
import 'package:smartbeat_frontend/home/forms/diagnostico_form.dart';
import 'package:smartbeat_frontend/home/forms/medical_prescriptions_form.dart';
import 'package:smartbeat_frontend/home/models/create_diagnostic.dart';
import 'package:smartbeat_frontend/home/models/medical_prescription.dart';
import 'package:smartbeat_frontend/home/models/register_diagnostic_req.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class RegisterDiagnosticCubit extends Cubit<RegisterDiagnosticState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;
  DiagnosticoForm diagnosticoForm = DiagnosticoForm();
  MedicalPrescriptionForm medicalPrescriptionsFrom = MedicalPrescriptionForm();
  List<MedicalPrescription> listMedicalPrescription = [];

  RegisterDiagnosticCubit() : super(RegisterDiagnosticInitial());

  Future<void> registrarDiagnostic(int medicalRecordId) async {
    try {
      emit(RegisterDiagnosticLoading());
      RegisterDiagnosticReq req = RegisterDiagnosticReq(
          createDiagnostic: CreateDiagnostic.from(diagnosticoForm.rawValue),
          listMedicalPrescription: listMedicalPrescription);
      await _consultaMedicaService.createDiagnostic(req, medicalRecordId);
      emit(RegisterDiagnosticSuccess());
    } on ServiceException catch (e) {
      emit(RegisterDiagnosticFailure(e.message));
    }
  }
}
