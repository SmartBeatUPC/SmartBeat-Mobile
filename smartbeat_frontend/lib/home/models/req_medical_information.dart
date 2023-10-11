class ReqMedicalInformation {
  final double height;
  final double weight;
  final double bmi;
  final bool sedentary;
  final bool smoke;
  final bool alcohol;

  const ReqMedicalInformation({
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

  ReqMedicalInformation.from(Map<String, dynamic> data)
      : height = data['talla'],
        weight = data['peso'],
        bmi = data['peso'] / (data['talla'] * data['talla']),
        sedentary = data['realizasteActividadFisica'],
        smoke = data['fumasteEstaSemana'],
        alcohol = data['tomasteAlcohol'];
}
