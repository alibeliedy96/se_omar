
import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/login/domain/models/forgot_password_response.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/login_or_register_response.dart';
import '../repositories/auth_repository_interface.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import 'auth_service_interface.dart';

class AuthService implements AuthServiceInterface{
  AuthRepositoryInterface authRepositoryInterface;

  AuthService({required this.authRepositoryInterface});



  @override
  Future<Either<Failure, LoginOrRegisterResponse>> login({required LoginRequestModel loginBody}) async{
    return await authRepositoryInterface.login( loginBody: loginBody,  );
  }

  @override
  Future<Either<Failure, LoginOrRegisterResponse>> registerUser({required RegisterRequest register})async {
    return await authRepositoryInterface.registerUser(register: register);
  }

  @override
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({required String email}) async {
    return await authRepositoryInterface.forgotPassword(email: email);
  }




}

 

