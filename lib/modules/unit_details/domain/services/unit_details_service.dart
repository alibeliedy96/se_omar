
import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/explore/domain/models/slider_response.dart';
import 'package:mr_omar/modules/explore/domain/models/units_response.dart';
import 'package:mr_omar/modules/unit_details/domain/models/unit_details_response.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../repositories/unit_details_repository_interface.dart';

import 'unit_details_service_interface.dart';

class UnitDetailsService implements UnitDetailsServiceInterface{
  UnitDetailsRepositoryInterface unitDetailsRepositoryInterface;

  UnitDetailsService({required this.unitDetailsRepositoryInterface});

  @override
  Future<Either<Failure, UnitDetailsResponse>> unitDetails({required String id})async {
    return await unitDetailsRepositoryInterface.unitDetails(id:id );
  }







}

 

