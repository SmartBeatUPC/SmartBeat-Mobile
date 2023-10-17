class MedicalInformationComplete {
  final int medicalRecordId;
  final String height;
  final String weight;
  final bool smoke;
  final bool alcohol;
  final bool sedentary;
  final String bmi;
  final String heartRate;
  final String bloodPressureSistolic;
  final String bloodPressureDiastolic;
  final String diagnosticExist;
  final List<String> pathologies;

  MedicalInformationComplete({
    required this.medicalRecordId,
    required this.height,
    required this.weight,
    required this.smoke,
    required this.bmi,
    required this.heartRate,
    required this.alcohol,
    required this.sedentary,
    required this.diagnosticExist,
    required this.bloodPressureSistolic,
    required this.bloodPressureDiastolic,
    required this.pathologies,
  });

  MedicalInformationComplete.from(Map<String, dynamic> data)
      : medicalRecordId = data['medicalRecordId'],
        height = data['height'],
        weight = data['weight'],
        smoke = data['smoke'],
        bmi = data['bmi'],
        heartRate = '${data['heartRate']}',
        alcohol = data['alcohol'],
        sedentary = data['sedentary'],
        bloodPressureSistolic = data['bloodPressureSistolic'],
        diagnosticExist = data['diagnosticExist'],
        bloodPressureDiastolic = data['bloodPressureDiastolic'],
        pathologies = (data['pathologies'] as List<dynamic>)
            .map((item) => item.toString())
            .toList();
}
