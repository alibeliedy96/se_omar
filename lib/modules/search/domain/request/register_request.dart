class RegisterRequest {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
  });


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }


  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      password: json["password"],
      passwordConfirmation: json["password_confirmation"],
    );
  }
}
