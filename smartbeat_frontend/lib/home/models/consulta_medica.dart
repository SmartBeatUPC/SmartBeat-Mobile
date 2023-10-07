import 'package:smartbeat_frontend/home/models/consultation.dart';
import 'package:smartbeat_frontend/seguridad/models/user.dart';

class ConsultaMedica {
  final Consultation consultation;
  final User doctorData;
  final String lastRecordDate;

  ConsultaMedica({
    required this.consultation,
    required this.doctorData,
    required this.lastRecordDate,
  });

  ConsultaMedica.from(Map<String, dynamic> data)
      : consultation = Consultation.from(data['consultation']),
        doctorData = User.from(data['doctorData']),
        lastRecordDate = data['lastRecordDate'];
}