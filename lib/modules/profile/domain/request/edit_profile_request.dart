class EditProfileRequest {
  final String name;
  final String email;
  final String phoneNumber;


  EditProfileRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,

  });


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,

    };
  }


  factory EditProfileRequest.fromJson(Map<String, dynamic> json) {
    return EditProfileRequest(
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phone_number"],

    );
  }
}
