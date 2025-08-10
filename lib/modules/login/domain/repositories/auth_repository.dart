import 'package:dartz/dartz.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';

import '../../../../utils/help_me.dart';
import '../models/login_or_register_response.dart';
import '../models/logout_response.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements AuthRepositoryInterface{

  AuthRepository( );

  @override
  Future<Either<Failure, LoginOrRegisterResponse>> login({
    required LoginRequestModel loginBody,
  }) async {
    return await handleResponse(
        endPoint: EndPoints.LOGIN_URI,
        asObject: (e) => LoginOrRegisterResponse.fromJson(e),
        method: DioMethod.post,
        data:loginBody.toJson()


    );
  }
  @override
  Future<Either<Failure, LogoutResponse>> deleteAccount() async {
    return await handleResponse(
      endPoint: EndPoints.deleteAccount,
      asObject: (e) => LogoutResponse.fromJson(e),
      method: DioMethod.post,

    );
  }
  @override
  Future<Either<Failure,LogoutResponse>> logout() async {
    return await handleResponse(
      endPoint: EndPoints.LOGOUT_URI,
      asObject: (e) => LogoutResponse.fromJson(e),
      method: DioMethod.post,

      // page: page,

    );
  }




  @override
  Future<Either<Failure, LoginOrRegisterResponse>> registerUser(
      {required RegisterRequest register}) async {
     printLog("register is ${register.toJson()}");
    return await handleResponse(
        endPoint: EndPoints.REGISTRATION_URI,
        asObject: (e) {
          return LoginOrRegisterResponse.fromJson(e);
        },
        method: DioMethod.post,
        data: register.toJson()


    );
  }





}