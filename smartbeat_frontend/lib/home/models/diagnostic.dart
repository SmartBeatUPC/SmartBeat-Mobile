import 'package:smartbeat_frontend/home/models/create_diagnostic.dart';
import 'package:smartbeat_frontend/home/models/medical_prescription.dart';

class Diagnostic {
  final CreateDiagnostic diagnostic;
  final List<MedicalPrescription> medicalPrescriptions;

  const Diagnostic({
    required this.diagnostic,
    required this.medicalPrescriptions,
  });

  Map<String, dynamic> toMap() => {
        'createDiagnosticDto': diagnostic.toMap(),
        'medicalPrescriptions': medicalPrescriptions.map((element) {
          return element.toMap();
        }).toList(),
      };

  Diagnostic.from(Map<String, dynamic> data)
      : diagnostic = CreateDiagnostic.from(data['diagnostic']),
        medicalPrescriptions = (data['medicalPrescriptions'] as List<dynamic>)
            .map((item) => MedicalPrescription.from(item))
            .toList();
}
