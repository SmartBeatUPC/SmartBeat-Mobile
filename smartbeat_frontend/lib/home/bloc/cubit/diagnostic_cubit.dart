import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/states/diagnostic_state.dart';
import 'package:smartbeat_frontend/home/models/diagnostic.dart';
import 'package:smartbeat_frontend/home/services/consultas_medicas_service.dart';
import 'package:smartbeat_frontend/shared/exception/service_exception.dart';

class DiagnosticCubit extends Cubit<DiagnosticState> {
  final ConsultaMedicaService _consultaMedicaService =
      ConsultaMedicaService.instance;

  DiagnosticCubit() : super(DiagnosticInitial());

  Future<void> getDiagnostic(int medicalRecordId) async {
    try {
      emit(DiagnosticLoading());
      Diagnostic diagnostic = await _consultaMedicaService
          .getDiagnosticByMedicalRecordId(medicalRecordId);
      emit(DiagnosticSuccess(diagnostic));
    } on ServiceException catch (e) {
      emit(DiagnosticFailure(e.message));
    }
  }
}
