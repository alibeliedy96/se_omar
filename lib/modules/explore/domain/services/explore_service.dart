
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/login_or_register_response.dart';
import '../repositories/explore_repository_interface.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import 'explore_service_interface.dart';

class ExploreService implements ExploreServiceInterface{
  ExploreRepositoryInterface exploreRepositoryInterface;

  ExploreService({required this.exploreRepositoryInterface});



  @override
  Future<Either<Failure, LoginOrRegisterResponse>> login({required LoginRequestModel loginBody}) async{
    return await exploreRepositoryInterface.login( loginBody: loginBody,  );
  }

  @override
  Future<Either<Failure, LoginOrRegisterResponse>> registerUser({required RegisterRequest register})async {
    return await exploreRepositoryInterface.registerUser(register: register);
  }




}

 

