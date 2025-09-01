
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';

import '../models/forgot_password_response.dart';
import '../models/login_or_register_response.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';

 

abstract class AuthServiceInterface{

  Future<Either<Failure, LoginOrRegisterResponse>> login({
    required LoginRequestModel loginBody,
  });



  Future<Either<Failure, LoginOrRegisterResponse>> registerUser(
      {required RegisterRequest register});

  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword(
      {required String email});


}