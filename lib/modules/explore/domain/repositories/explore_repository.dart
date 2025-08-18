import 'package:dartz/dartz.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/slider_response.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import '../models/units_response.dart';
import 'explore_repository_interface.dart';

class ExploreRepository implements ExploreRepositoryInterface{

  ExploreRepository( );

  @override
  Future<Either<Failure, SlidersResponse>> getSliders() async {
    return await handleResponse(
        endPoint: EndPoints.sliders,
        asObject: (e) => SlidersResponse.fromJson(e),
        method: DioMethod.get,
    );
  }

  @override
  Future<Either<Failure, UnitsResponse>> getUnits() async {
    return await handleResponse(
        endPoint: EndPoints.units,
        asObject: (e) => UnitsResponse.fromJson(e),
        method: DioMethod.get,
    );
  }







}