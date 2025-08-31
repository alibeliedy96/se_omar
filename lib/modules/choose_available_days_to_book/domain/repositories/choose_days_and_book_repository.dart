import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import '../models/bulk_pricing_response.dart';
import '../models/create_reservatons_response.dart';
import '../models/reserved_days_response.dart';
import '../request/bulk_pricing_request.dart';
import '../request/create_reservation_request.dart';
import 'choose_days_and_book_repository_interface.dart';

class ChooseDaysAndBookRepository implements ChooseDaysAndBookRepositoryInterface{

  ChooseDaysAndBookRepository( );

  @override
  Future<Either<Failure, ReservedDaysResponse>> reservedDays({
    required String unitId,
    required String startDate,
    required String endDate,
  }) async {
    final endpoint = "${EndPoints.baseUrl}/api/units/$unitId/reserved-days"
        "?start_date=$startDate&end_date=$endDate";

    return await handleResponse(
      endPoint: endpoint,
      asObject: (e) => ReservedDaysResponse.fromJson(e),
      method: DioMethod.get,
    );
  }
  @override
  Future<Either<Failure, BulkPricingResponse>> bulkPricing({required BulkPricingRequest bulkPricingRequest,}) async {


    return await handleResponse(
      endPoint: EndPoints.bulkPricing,
      asObject: (e) => BulkPricingResponse.fromJson(e),
      method: DioMethod.post,
      data: bulkPricingRequest.toJson()
    );
  }
  
  @override
  Future<Either<Failure, CreateReservationsResponse>> createReservation({required CreateReservationRequest createReservationRequest,}) async {

    final formData = await createReservationRequest.toFormData();
    return await handleResponse(
      endPoint: EndPoints.createReservations,
      asObject: (e) => CreateReservationsResponse.fromJson(e),
      method: DioMethod.post,
      data: formData
    );
  }









}