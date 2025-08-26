import '../../../../../../core/get_it/get_it.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';
import '../../domain/models/bulk_pricing_response.dart';
import '../../domain/models/reserved_days_response.dart';

import '../../domain/request/bulk_pricing_request.dart';
import '../../domain/services/choose_days_and_book_service.dart';


enum ChooseDaysAndBookApiTypes {  loadInitialData,  reservedDays ,bulkPricing}

class ChooseDaysAndBookCubit extends BaseCubit<ChooseDaysAndBookApiTypes>   {
  final ChooseDaysAndBookService  repo;
  ChooseDaysAndBookCubit({required this.repo}): super(ChooseDaysAndBookApiTypes.loadInitialData);
  static ChooseDaysAndBookCubit get() => getIt<ChooseDaysAndBookCubit>();



  /// reserved Days

  Future reservedDays({required String unitId, required String startDate,
    required String endDate,required Function(ReservedDaysResponse response)  onSuccess}) async {

   await fastFire<ReservedDaysResponse>(
    type: ChooseDaysAndBookApiTypes.reservedDays,
    fun: () {
      return repo.reservedDays(unitId: unitId, startDate: startDate, endDate: endDate);
    },
    onSuccess: (r) {
     if(r.data != null ){
       onSuccess.call(r);
     }
    },
    onFailure: (l) {
      printLog("l is");
      },
  );
  }

  /// bulk Pricing for checkout cal every thing

  Future bulkPricing({required BulkPricingRequest bulkPricingRequest,
    required Function(BulkPricingResponse response)  onSuccess }) async {

   await fastFire<BulkPricingResponse>(
    type: ChooseDaysAndBookApiTypes.bulkPricing,
    fun: () {
      return repo.bulkPricing(bulkPricingRequest: bulkPricingRequest);
    },
    onSuccess: (r) {
     if(r.data != null ){
       onSuccess.call(r);
     }
    },
    onFailure: (l) {
      printLog("l is");
      },
  );
  }






}


