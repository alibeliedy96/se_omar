
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/get_profile_response.dart';
import '../models/logout_response.dart';


 

abstract class ProfileServiceInterface{

  Future<Either<Failure, GetProfileResponse>> getProfile();
  Future<Either<Failure, LogoutResponse>> logout();


}