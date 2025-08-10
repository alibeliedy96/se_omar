import 'package:dartz/dartz.dart';

import '../../../../../../core/api/error/error_handler/failure.dart';
import '../models/login_or_register_response.dart';
import '../models/logout_response.dart';


import '../request/login_request.dart';
import '../request/register_request.dart';



abstract class AuthRepositoryInterface {
  Future<Either<Failure, LoginOrRegisterResponse>> login({
    required LoginRequestModel loginBody,
  });


  Future<Either<Failure, LogoutResponse>> logout();

  Future<Either<Failure, LogoutResponse>> deleteAccount();

  Future<Either<Failure, LoginOrRegisterResponse>> registerUser(
      {required RegisterRequest register});
}


