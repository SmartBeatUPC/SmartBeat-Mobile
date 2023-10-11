class RegisterConsultaMedicaReq {
  final int doctorId;
  final int patientId;

  const RegisterConsultaMedicaReq({
    required this.doctorId,
    required this.patientId,
  });

  Map<String, dynamic> toMap() => {
    'doctorId': doctorId,
    'patientId': patientId,
  };
}
