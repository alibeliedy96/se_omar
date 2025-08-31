import 'package:dartz/dartz.dart';
import '../../../../../../core/api/error/error_handler/failure.dart';
import '../models/bulk_pricing_response.dart';
import '../models/create_reservatons_response.dart';
import '../models/reserved_days_response.dart';
import '../request/bulk_pricing_request.dart';
import '../request/create_reservation_request.dart';


abstract class ChooseDaysAndBookRepositoryInterface {
  Future<Either<Failure, ReservedDaysResponse>> reservedDays({
    required String unitId,
    required String startDate,
    required String endDate,
  });

  Future<Either<Failure, BulkPricingResponse>> bulkPricing({required BulkPricingRequest bulkPricingRequest,});
  Future<Either<Failure, CreateReservationsResponse>> createReservation({required CreateReservationRequest createReservationRequest,});
}