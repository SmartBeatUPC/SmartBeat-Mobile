import 'package:smartbeat_frontend/home/models/create_diagnostic.dart';
import 'package:smartbeat_frontend/home/models/medical_prescription.dart';

class RegisterDiagnosticReq {
  final CreateDiagnostic createDiagnostic;
  final List<MedicalPrescription> listMedicalPrescription;

  const RegisterDiagnosticReq({
    required this.createDiagnostic,
    required this.listMedicalPrescription,
  });

  Map<String, dynamic> toMap() => {
        'createDiagnosticDto': createDiagnostic.toMap(),
        'medicalPrescriptions': listMedicalPrescription.map((element) {
          return element.toMap();
        }).toList(),
      };
}
