import 'package:flutter/cupertino.dart';

import '../../../../../../core/get_it/get_it.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';
import '../../../../utils/uti.dart';
import '../../domain/models/cancel_reservsations_response.dart';
import '../../domain/models/get_reservations_response.dart';
import '../../domain/services/reservations_service.dart';


enum ReservationsApiTypes {  loadInitialData,reservations ,cancelReservations }

class ReservationsCubit extends BaseCubit<ReservationsApiTypes>   {
  final ReservationsService  repo;
  ReservationsCubit({required this.repo}): super(ReservationsApiTypes.loadInitialData);
  static ReservationsCubit get() => getIt<ReservationsCubit>();




  /// fetch all  Reservations
  List<ReservationsData> _reservations= [];


  List<ReservationsData> get  reservations => _reservations;

  Future getReservations({required PaginationMethod paginationMethod,required String status }) async {
    return await fastPagination<GetReservationsResponse>(
        type:  ReservationsApiTypes.reservations,
        fun: (int page) =>  repo.getReservations(page: page,status:status),
        onRefreshSuccess: (r) => _reservations = r.data??[],
        onLoadMoreSuccess: (r) => _reservations.addAll(r.data??[]),
        toMeta: (r) => r.pagination,

        paginationMethod: paginationMethod);
  }



  Future cancelReservations({required BuildContext context,required String id }) async {

    return await fastFire<CancelReservationsResponse>(
      type: ReservationsApiTypes.cancelReservations,
      fun: () {
        return repo.cancelReservations(id:id);
      },
      onSuccess: (r) {
        if(r.success==true){
          Navigator.of(context).pop();

          getReservations(paginationMethod: PaginationMethod.refresh,status: "pending");
        }
      },
      onFailure: (l) {
        printLog("l is");


        UTI.showSnackBar(context, l.message, 'error');

      }  ,
    );
  }


}


