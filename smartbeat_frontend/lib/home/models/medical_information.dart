class MedicalInformation {
  final double height;
  final double weight;
  final double bmi;
  final bool sedentary;
  final bool smoke;
  final bool alcohol;

  const MedicalInformation({
    required this.height,
    required this.weight,
    required this.bmi,
    required this.sedentary,
    required this.smoke,
    required this.alcohol,
  });

  Map<String, dynamic> toMap() => {
    'height': height,
    'weight': weight,
    'bmi': bmi,
    'sedentary': sedentary,
    'smoke': smoke,
    'alcohol': alcohol,
  };
}
