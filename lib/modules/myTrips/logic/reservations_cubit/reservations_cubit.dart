import '../../../../../../core/get_it/get_it.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';
import '../../domain/models/get_reservations_response.dart';
import '../../domain/services/reservations_service.dart';


enum ReservationsApiTypes {  loadInitialData,reservations  }

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


}


