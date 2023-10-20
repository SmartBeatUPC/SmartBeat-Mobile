import 'package:smartbeat_frontend/home/models/medical_information.dart';

class LastMedicalInformation {
  final MedicalInformation lastMedicalInformation;
  final List<String> patologias;

  const LastMedicalInformation({
    required this.lastMedicalInformation,
    required this.patologias,
  });

  Map<String, dynamic> toMap() => {
        'lastMedicalInformation': lastMedicalInformation,
        'pathologies': patologias,
      };

  LastMedicalInformation.from(Map<String, dynamic> data)
      : lastMedicalInformation =
            MedicalInformation.from(data['lastMedicalInformation']),
        patologias = (data['pathologies'] as List<dynamic>)
            .map((item) => item.toString())
            .toList();
}
