class   PredictionReq {
  final bool methodology;
  final int patientId;
  final int medicalInformationId;

  const PredictionReq({
    required this.methodology,
    required this.patientId,
    required this.medicalInformationId,
  });

  Map<String, dynamic> toMap() => {
        'methodology': methodology,
        'patientId': patientId,
        'medicalInformationId': medicalInformationId,
      };
}
