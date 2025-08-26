
import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/choose_available_days_to_book/domain/models/bulk_pricing_response.dart';
import 'package:mr_omar/modules/choose_available_days_to_book/domain/models/reserved_days_response.dart';
import 'package:mr_omar/modules/choose_available_days_to_book/domain/request/bulk_pricing_request.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../repositories/choose_days_and_book_repository_interface.dart';

import 'choose_days_and_book_service_interface.dart';

class ChooseDaysAndBookService implements ChooseDaysAndBookServiceInterface{
  ChooseDaysAndBookRepositoryInterface chooseDaysAndBookRepositoryInterface;

  ChooseDaysAndBookService({required this.chooseDaysAndBookRepositoryInterface});



  @override
  Future<Either<Failure, ReservedDaysResponse>> reservedDays({required String unitId, required String startDate, required String endDate}) async {
    return await chooseDaysAndBookRepositoryInterface.reservedDays(unitId:unitId,endDate: endDate,startDate: startDate );
  }

  @override
  Future<Either<Failure, BulkPricingResponse>> bulkPricing({required BulkPricingRequest bulkPricingRequest})async {
    return await chooseDaysAndBookRepositoryInterface.bulkPricing(bulkPricingRequest:bulkPricingRequest );
  }







}

 

