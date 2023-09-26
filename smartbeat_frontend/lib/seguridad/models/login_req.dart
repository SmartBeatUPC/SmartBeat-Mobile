class LoginReq {
  String email;
  String password;

  LoginReq({
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toMap() => {
    'email': email,
    'password': password,
  };

  LoginReq.from(Map<String, dynamic> data)
      : email = data['email'],
        password = data['password'];
}
