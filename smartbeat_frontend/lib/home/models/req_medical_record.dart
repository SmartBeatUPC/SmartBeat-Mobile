class RequestMedicalRecord {
  final String recordDate;

  const RequestMedicalRecord({
    required this.recordDate,
  });

  Map<String, dynamic> toMap() => {
    'recordDate': recordDate,
  };
}
