import 'package:dartz/dartz.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/get_profile_response.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import '../models/logout_response.dart';
import 'profile_repository_interface.dart';

class ProfileRepository implements ProfileRepositoryInterface{

  ProfileRepository( );

  @override
  Future<Either<Failure, GetProfileResponse>> getProfile() async {
    return await handleResponse(
        endPoint: EndPoints.profile,
        asObject: (e) => GetProfileResponse.fromJson(e),
        method: DioMethod.get,



    );
  }

  @override
  Future<Either<Failure, LogoutResponse>> logout() async {
    return await handleResponse(
        endPoint: EndPoints.logout,
        asObject: (e) => LogoutResponse.fromJson(e),
        method: DioMethod.post,



    );
  }

}