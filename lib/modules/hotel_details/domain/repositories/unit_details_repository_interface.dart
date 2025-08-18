import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/hotel_details/domain/models/unit_details_response.dart';
import '../../../../../../core/api/error/error_handler/failure.dart';


abstract class UnitDetailsRepositoryInterface {
  Future<Either<Failure, UnitDetailsResponse>> unitDetails({required String id});
}