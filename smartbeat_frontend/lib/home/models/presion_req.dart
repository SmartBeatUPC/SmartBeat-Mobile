class PresionReq {
  final double bloodPressureSistolic;
  final double bloodPressureDiastolic;
  final int bloodPresheartRatesureDiastolic;

  const PresionReq({
    required this.bloodPressureSistolic,
    required this.bloodPressureDiastolic,
    required this.bloodPresheartRatesureDiastolic,
  });

  Map<String, dynamic> toMap() => {
        'bloodPressureSistolic': bloodPressureSistolic.toStringAsFixed(2),
        'bloodPressureDiastolic': bloodPressureSistolic.toStringAsFixed(2),
        'heartRate': bloodPresheartRatesureDiastolic
      };

  PresionReq.from(Map<String, dynamic> data)
      : bloodPressureSistolic = data['bloodPressureSistolic'],
        bloodPressureDiastolic = data['bloodPressureDiastolic'],
        bloodPresheartRatesureDiastolic =
            data['bloodPresheartRatesureDiastolic'];
}
