import 'dart:io';
import 'package:dio/dio.dart';

class EditProfileRequest {
  final String name;
  final String email;
  final String phoneNumber;
  final File? profileImage;

  EditProfileRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
  });


  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
    };

    if (profileImage != null) {
      data["profile_image"] = await MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path.split('/').last,
      );
    }

    return FormData.fromMap(data);
  }




}
