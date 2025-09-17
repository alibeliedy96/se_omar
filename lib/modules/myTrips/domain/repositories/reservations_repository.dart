import 'package:dartz/dartz.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import '../models/cancel_reservsations_response.dart';
import '../models/get_reservations_response.dart';
import 'reservations_repository_interface.dart';

class ReservationsRepository implements ReservationsRepositoryInterface{

  ReservationsRepository( );

  @override
  Future<Either<Failure, GetReservationsResponse>> getReservations({required int page,required String status}) async {
    return await handleResponse(
        endPoint: EndPoints.reservations,
        asObject: (e) => GetReservationsResponse.fromJson(e),
        method: DioMethod.get,
        page: page,
      query: {
          "status":status
      }
    );
  }

  @override
  Future<Either<Failure, CancelReservationsResponse>> cancelReservations({required String id  }) async {
    return await handleResponse(
        endPoint: EndPoints.cancelReservations(id),
        asObject: (e) => CancelReservationsResponse.fromJson(e),
        method: DioMethod.post,

    );
  }







}