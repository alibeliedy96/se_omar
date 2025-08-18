
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/change_password_response.dart';
import '../models/profile_response.dart';
import '../models/logout_response.dart';
import '../request/change_password_request.dart';
import '../request/edit_profile_request.dart';


 

abstract class ProfileServiceInterface{

  Future<Either<Failure, ProfileResponse>> getProfile();
  Future<Either<Failure, LogoutResponse>> logout();
  Future<Either<Failure,ProfileResponse>> editProfile({required EditProfileRequest editProfileRequest});
  Future<Either<Failure,ChangePasswordResponse>> changePassword({required ChangePasswordRequest changePasswordRequest});


}