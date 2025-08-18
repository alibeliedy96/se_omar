
import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/explore/domain/models/slider_response.dart';
import 'package:mr_omar/modules/explore/domain/models/units_response.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../repositories/explore_repository_interface.dart';

import 'explore_service_interface.dart';

class ExploreService implements ExploreServiceInterface{
  ExploreRepositoryInterface exploreRepositoryInterface;

  ExploreService({required this.exploreRepositoryInterface});

  @override
  Future<Either<Failure, SlidersResponse>> getSliders() async {
  return await exploreRepositoryInterface.getSliders();
  }

  @override
  Future<Either<Failure, UnitsResponse>> getUnits() async {
    return await exploreRepositoryInterface.getUnits();
  }






}

 

