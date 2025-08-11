import 'package:dartz/dartz.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/profile_response.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import '../models/logout_response.dart';
import '../request/edit_profile_request.dart';
import 'profile_repository_interface.dart';

class ProfileRepository implements ProfileRepositoryInterface{

  ProfileRepository( );

  @override
  Future<Either<Failure, ProfileResponse>> getProfile() async {
    return await handleResponse(
        endPoint: EndPoints.profile,
        asObject: (e) => ProfileResponse.fromJson(e),
        method: DioMethod.get,



    );
  }
  @override
  Future<Either<Failure, ProfileResponse>> editProfile({required EditProfileRequest editProfileRequest})async {
    return await handleResponse(
        endPoint: EndPoints.profile,
        asObject: (e) => ProfileResponse.fromJson(e),
        method: DioMethod.put,
        data:  editProfileRequest.toJson()



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