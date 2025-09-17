
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/cancel_reservsations_response.dart';
import '../models/get_reservations_response.dart';


 

abstract class ReservationsServiceInterface{

  Future<Either<Failure, GetReservationsResponse>> getReservations({required int page,required String status});
  Future<Either<Failure, CancelReservationsResponse>> cancelReservations({required String id  });
}