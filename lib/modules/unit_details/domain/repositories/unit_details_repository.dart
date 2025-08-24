import 'package:dartz/dartz.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import '../models/unit_details_response.dart';
import 'unit_details_repository_interface.dart';

class UnitDetailsRepository implements UnitDetailsRepositoryInterface{

  UnitDetailsRepository( );

  @override
  Future<Either<Failure, UnitDetailsResponse>> unitDetails({required String id}) async {
    return await handleResponse(
        endPoint: EndPoints.unitDetails(id),
        asObject: (e) => UnitDetailsResponse.fromJson(e),
        method: DioMethod.get,
    );
  }








}