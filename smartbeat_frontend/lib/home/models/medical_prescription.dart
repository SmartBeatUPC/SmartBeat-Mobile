class MedicalPrescription {
  final String medicament;
  final String dosage;
  final String via;
  final String frequency;
  final String duration;

  const MedicalPrescription({
    required this.medicament,
    required this.dosage,
    required this.via,
    required this.frequency,
    required this.duration,
  });

  Map<String, dynamic> toMap() => {
        'medicament': medicament,
        'dosage': dosage,
        'via': via,
        'frequency': frequency,
        'duration': duration,
      };

  MedicalPrescription.from(Map<String, dynamic> data)
      : medicament = data['medicament'],
        dosage = data['dosage'],
        via = data['via'],
        frequency = data['frequency'],
        duration = data['duration'];
}
