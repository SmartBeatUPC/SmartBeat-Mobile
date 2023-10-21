class PPG {
  final int id;
  final int bloodPressureSistolic;
  final int bloodPressureDiastolic;
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
        bloodPressureSistolic =
            double.parse(data['bloodPressureSistolic']).toInt(),
        bloodPressureDiastolic =
            double.parse(data['bloodPressureDiastolic']).toInt(),
        heartRate = data['heartRate'],
        ppgDate = data['ppgDate'],
        ppgBar = data['ppgBar'],
        ppgClasification = data['ppgClasification'],
        medicalInformationId = data['medicalInformationId'];
}
