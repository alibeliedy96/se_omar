import 'package:dartz/dartz.dart';

import '../../../../../../core/api/error/error_handler/failure.dart';
import '../models/get_reservations_response.dart';




abstract class ReservationsRepositoryInterface {

  Future<Either<Failure, GetReservationsResponse>> getReservations({required int page,required String status});
}