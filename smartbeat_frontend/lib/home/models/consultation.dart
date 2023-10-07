class Consultation {
  final int id;
  final int doctorId;
  final int patientId;

  Consultation({
    required this.id,
    required this.doctorId,
    required this.patientId,
  });

  Consultation.from(Map<String, dynamic> data)
      : id = data['id'],
        doctorId = data['doctorId'],
        patientId = data['patientId'];
}