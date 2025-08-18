import '../../../../../../core/get_it/get_it.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';
import '../../domain/models/unit_details_response.dart';
import '../../domain/services/unit_details_service.dart';


enum UnitDetailsApiTypes {  loadInitialData,  unitDetails ,}

class UnitDetailsCubit extends BaseCubit<UnitDetailsApiTypes>   {
  final UnitDetailsService  repo;
  UnitDetailsCubit({required this.repo}): super(UnitDetailsApiTypes.loadInitialData);
  static UnitDetailsCubit get() => getIt<UnitDetailsCubit>();



  /// unit details
  UnitDetailsData? _detailsData;
  UnitDetailsData?  get  detailsData=> _detailsData;
  Future unitDetails({required String id}) async {

   await fastFire<UnitDetailsResponse>(
    type: UnitDetailsApiTypes.unitDetails,
    fun: () {
      return repo.unitDetails(id: id);
    },
    onSuccess: (r) {
     if(r.data != null ){
       _detailsData=r.data!;
     }
    },
    onFailure: (l) {
      printLog("l is");
      },
  );
  }






}


