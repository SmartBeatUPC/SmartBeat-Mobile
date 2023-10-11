import 'package:smartbeat_frontend/home/models/consultation.dart';
import 'package:smartbeat_frontend/seguridad/models/user.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';

class ConsultaMedica {
  final Consultation consultation;
  final User doctorData;
  final String lastRecordDate;
  final int lastMedicalRecordId;

  ConsultaMedica({
    required this.consultation,
    required this.doctorData,
    required this.lastRecordDate,
    required this.lastMedicalRecordId,
  });

  ConsultaMedica.from(Map<String, dynamic> data, TypeUser typeUser)
      : consultation = Consultation.from(data['consultation']),
        doctorData = User.from(
            data[typeUser == TypeUser.patient ? 'doctorData' : 'patientData']),
        lastRecordDate = data['lastRecordDate'],
        lastMedicalRecordId =
            int.tryParse('${data['lastMedicalRecordId']}') ?? 0;
}
