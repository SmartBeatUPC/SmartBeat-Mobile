class MedicalInformation {
  final String height;
  final String weight;
  final String bmi;
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
        'sedentary': !sedentary,
        'smoke': smoke,
        'alcohol': alcohol,
      };

  MedicalInformation.from(Map<String, dynamic> data)
      : height = data['height'],
        weight = data['weight'],
        bmi = data['bmi'],
        sedentary = data['sedentary'],
        smoke = data['smoke'],
        alcohol = data['alcohol'];
}
