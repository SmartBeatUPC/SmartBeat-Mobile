class InfoApp {
  final String dni;
  final String nombres;

  const InfoApp({
    required this.dni,
    required this.nombres,
  });

  InfoApp.from(Map<String, dynamic> data)
      : this.dni = data['dni'],
        this.nombres = data['nombres'];

  Map<String, dynamic> toMap() {
    return {
      'dni': dni,
      'nombres': nombres,
    };
  }
}
