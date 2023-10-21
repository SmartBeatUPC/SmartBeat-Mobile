class PresionReq {
  final int bloodPressureSistolic;
  final int bloodPressureDiastolic;
  final int bloodPresheartRatesureDiastolic;

  const PresionReq({
    required this.bloodPressureSistolic,
    required this.bloodPressureDiastolic,
    required this.bloodPresheartRatesureDiastolic,
  });

  Map<String, dynamic> toMap() => {
        'bloodPressureSistolic': '$bloodPressureSistolic',
        'bloodPressureDiastolic': '$bloodPressureDiastolic',
        'heartRate': bloodPresheartRatesureDiastolic
      };

  PresionReq.from(Map<String, dynamic> data)
      : bloodPressureSistolic = data['bloodPressureSistolic'],
        bloodPressureDiastolic = data['bloodPressureDiastolic'],
        bloodPresheartRatesureDiastolic =
            data['bloodPresheartRatesureDiastolic'];
}
