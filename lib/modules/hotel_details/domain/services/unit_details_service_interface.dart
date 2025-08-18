
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/unit_details_response.dart';


 

abstract class UnitDetailsServiceInterface{

  Future<Either<Failure, UnitDetailsResponse>> unitDetails({required String id});
}