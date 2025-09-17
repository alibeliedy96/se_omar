import 'package:flutter/material.dart';

import '../../../../../../core/get_it/get_it.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';
import '../../../../utils/uti.dart';
import '../../domain/models/create_review_response.dart';
import '../../domain/models/unit_details_response.dart';
import '../../domain/request/create_review_request.dart';
import '../../domain/services/unit_details_service.dart';


enum UnitDetailsApiTypes {  loadInitialData,  unitDetails ,createReview}

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


  Future   createReview({required CreateReviewRequestModel createReviewRequestModel,required BuildContext context})async {

   await fastFire<CreateReviewResponse>(
    type: UnitDetailsApiTypes.createReview,
    fun: () {
      return repo.createReview(createReviewRequestModel: createReviewRequestModel);
    },
    onSuccess: (r) {
     if(r.success ==true ){
       unitDetails(id: createReviewRequestModel.unitId.toString());
     }
    },
    onFailure: (l) {
      printLog("l is");
      UTI.showSnackBar(context, l.message, 'error');
      },
  );
  }






}


