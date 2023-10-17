class PPG {
  final int id;
  final String bloodPressureSistolic;
  final String bloodPressureDiastolic;
  final int heartRate;
  final String ppgDate;
  final int medicalInformationId;
  final int ppgBar;
  final String ppgClasification;

  PPG({
    required this.id,
    required this.bloodPressureSistolic,
    required this.bloodPressureDiastolic,
    required this.heartRate,
    required this.ppgDate,
    required this.medicalInformationId,
    required this.ppgBar,
    required this.ppgClasification,
  });

  PPG.from(Map<String, dynamic> data)
      : id = data['id'],
        bloodPressureSistolic = data['bloodPressureSistolic'],
        bloodPressureDiastolic = data['bloodPressureDiastolic'],
        heartRate = data['heartRate'],
        ppgDate = data['ppgDate'],
        ppgBar = data['ppgBar'],
        ppgClasification = data['ppgClasification'],
        medicalInformationId = data['medicalInformationId'];
}
