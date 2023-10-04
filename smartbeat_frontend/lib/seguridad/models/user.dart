class User {
  int? id;
  String? name;
  String? lastName;
  int? age;
  String? dni;
  String? gender;
  String? nationality;
  String? phone;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.age,
    required this.dni,
    required this.gender,
    this.nationality,
    required this.phone,
  });

  User.empty();

  User.from(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        lastName = data['lastName'],
        age = data['age'],
        dni = data['dni'],
        gender = data['gender'],
        phone = data['phone'];
}