import 'package:smartbeat_frontend/home/models/ppg.dart';

class HistorialMedicion {
  final int medicalRecordId;
  final PPG ppg;

  HistorialMedicion({
    required this.medicalRecordId,
    required this.ppg,
  });


  HistorialMedicion.from(Map<String, dynamic> data)
      : medicalRecordId = data['medicalRecordId'],
        ppg = PPG.from(data['ppg']);
}