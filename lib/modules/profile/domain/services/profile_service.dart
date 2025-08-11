
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/get_profile_response.dart';
import '../models/logout_response.dart';
import '../repositories/profile_repository_interface.dart';
import 'profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface{
  ProfileRepositoryInterface profileRepositoryInterface;

  ProfileService({required this.profileRepositoryInterface});



  @override
  Future<Either<Failure, GetProfileResponse>> getProfile()async{
    return await profileRepositoryInterface.getProfile();
  }


  @override
  Future<Either<Failure, LogoutResponse>> logout()async{
    return await profileRepositoryInterface.logout();
  }



}

 

