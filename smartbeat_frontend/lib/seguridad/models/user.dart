class User {
  int? idUser;
  String? name;
  String? lastName;
  int? age;
  String? dni;
  String? gender;
  String? nationality;
  String? phone;
  int? userId;

  User({
    required this.idUser,
    required this.name,
    required this.lastName,
    required this.age,
    required this.dni,
    required this.gender,
    required this.nationality,
    required this.phone,
    required this.userId,
  });

  User.empty();

  User.from(Map<String, dynamic> data)
      : idUser = data['idUser'],
        name = data['name'],
        lastName = data['lastName'],
        age = data['age'],
        dni = data['dni'],
        gender = data['gender'],
        phone = data['phone'],
        userId = data['userId'];

}