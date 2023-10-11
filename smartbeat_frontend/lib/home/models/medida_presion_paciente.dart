class MedidaPresionPaciente {
  final String sys;
  final String dia;
  final String bpm;
  final String? fechaHora;

  const MedidaPresionPaciente({
    required this.sys,
    required this.dia,
    required this.bpm,
    this.fechaHora,
  });
}
