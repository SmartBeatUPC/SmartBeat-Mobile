class Prediction {
  final String responseAssistance;
  final int totalTokens;

  const Prediction({
    required this.responseAssistance,
    required this.totalTokens,
  });

  Map<String, dynamic> toMap() => {
    'responseAssistance': responseAssistance,
    'totalTokens': totalTokens,
  };
  Prediction.from(Map<String, dynamic> data)
      : responseAssistance = data['responseAssistance'],
        totalTokens = data['totalTokens'];
}
