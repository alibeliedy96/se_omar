
import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/profile/domain/models/change_password_response.dart';
import 'package:mr_omar/modules/profile/domain/request/change_password_request.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/profile_response.dart';
import '../models/logout_response.dart';
import '../repositories/profile_repository_interface.dart';
import '../request/edit_profile_request.dart';
import 'profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface{
  ProfileRepositoryInterface profileRepositoryInterface;

  ProfileService({required this.profileRepositoryInterface});



  @override
  Future<Either<Failure, ProfileResponse>> getProfile()async{
    return await profileRepositoryInterface.getProfile();
  }


  @override
  Future<Either<Failure, LogoutResponse>> logout()async{
    return await profileRepositoryInterface.logout();
  }
  @override
  Future<Either<Failure, ProfileResponse>> editProfile({required EditProfileRequest editProfileRequest})async{
    return await profileRepositoryInterface.editProfile(editProfileRequest: editProfileRequest);
  }

  @override
  Future<Either<Failure, ChangePasswordResponse>> changePassword({required ChangePasswordRequest changePasswordRequest}) async {
    return await profileRepositoryInterface.changePassword(changePasswordRequest: changePasswordRequest);

  }



}

 

