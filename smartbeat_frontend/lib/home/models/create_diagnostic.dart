class CreateDiagnostic {
  final String diagnosticResult;

  const CreateDiagnostic({
    required this.diagnosticResult,
  });

  Map<String, dynamic> toMap() => {
        'diagnosticResult': diagnosticResult,
      };

  CreateDiagnostic.from(Map<String, dynamic> data)
      : diagnosticResult = data['diagnosticResult'];
}
