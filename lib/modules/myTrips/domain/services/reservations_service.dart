
import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/myTrips/domain/models/cancel_reservsations_response.dart';
import 'package:mr_omar/modules/myTrips/domain/models/get_reservations_response.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../repositories/reservations_repository_interface.dart';

import 'reservations_service_interface.dart';

class ReservationsService implements ReservationsServiceInterface{
  ReservationsRepositoryInterface reservationsRepositoryInterface;

  ReservationsService({required this.reservationsRepositoryInterface});

  @override
  Future<Either<Failure, GetReservationsResponse>> getReservations({required int page, required String status}) async {
    return await reservationsRepositoryInterface.getReservations(page: page, status: status);
  }

  @override
  Future<Either<Failure, CancelReservationsResponse>> cancelReservations({required String id}) async {
    return await reservationsRepositoryInterface.cancelReservations(id: id);
  }






}

 

