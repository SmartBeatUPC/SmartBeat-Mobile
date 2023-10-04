import 'package:smartbeat_frontend/home/models/medical_information.dart';

class PredictionReq {
  final bool methodology;
  final int age;
  final String gender;
  final MedicalInformation medicalInformation;
  final List<String> pathologies;

  const PredictionReq({
    required this.methodology,
    required this.age,
    required this.gender,
    required this.medicalInformation,
    required this.pathologies,
  });

  Map<String, dynamic> toMap() => {
        'methodology': methodology,
        'age': age,
        'gender': gender,
        'medicalInformation': medicalInformation.toMap(),
        'pathologies': {
          for (var item in pathologies)
            pathologies.indexOf(item).toString(): item
        },
      };
}
