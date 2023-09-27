class RegistroInicialReq {
  String email;
  String password;

  RegistroInicialReq({
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toMap() => {
    'email': email,
    'password': password,
  };

  RegistroInicialReq.from(Map<String, dynamic> data)
      : email = data['email'],
        password = data['password'];
}
