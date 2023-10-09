class Patologia {
  final String pathology;

  Patologia({
    required this.pathology,
  });

  Map<String, dynamic> toMap() => {
        'pathology': pathology,
      };
}
