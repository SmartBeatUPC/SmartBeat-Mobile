class RegistroAditonalUserData {
  String? name;
  String? lastName;
  int? age;
  String? dni;
  String? gender;
  String? nationality;
  String? phone;

  RegistroAditonalUserData({
    required this.name,
    required this.lastName,
    required this.age,
    required this.dni,
    required this.gender,
    required this.nationality,
    required this.phone,
  });

  RegistroAditonalUserData.empty();

  RegistroAditonalUserData.from(Map<String, dynamic> data)
      : name = data['name'],
        lastName = data['lastName'],
        age = int.parse(data['age']),
        dni = data['dni'],
        gender = data['gender'],
        nationality = data['nationality'],
        phone = data['phone'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'lastName': lastName,
        'age': age,
        'dni': dni,
        'gender': gender,
        'nationality': nationality,
        'phone': phone,
      };
}
