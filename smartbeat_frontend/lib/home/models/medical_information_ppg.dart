class MedicalInformationPpg {
  final int newMedicalInformationId;
  final String doctorLastName;
  final int ppgBar;
  final String ppgClasification;

  MedicalInformationPpg({
    required this.newMedicalInformationId,
    required this.doctorLastName,
    required this.ppgBar,
    required this.ppgClasification,
  });

  MedicalInformationPpg.from(Map<String, dynamic> data)
      : newMedicalInformationId = data['newMedicalInformation']['id'],
        doctorLastName = data['doctorLastName'],
        ppgBar = data['newPpg']['ppgBar'],
        ppgClasification = data['newPpg']['ppgClasification'];
}
