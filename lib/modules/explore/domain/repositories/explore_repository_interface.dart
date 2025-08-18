import 'package:dartz/dartz.dart';

import '../../../../../../core/api/error/error_handler/failure.dart';
import '../models/slider_response.dart';
import '../models/units_response.dart';




abstract class ExploreRepositoryInterface {
  Future<Either<Failure, SlidersResponse>> getSliders();

  Future<Either<Failure, UnitsResponse>> getUnits();
}