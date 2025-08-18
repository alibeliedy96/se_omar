import '../../../../../../core/get_it/get_it.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';
import '../../domain/models/slider_response.dart';
import '../../domain/models/units_response.dart';
import '../../domain/services/explore_service.dart';


enum ExploreApiTypes {  loadInitialData,  slider,units,}

class ExploreCubit extends BaseCubit<ExploreApiTypes>   {
  final ExploreService  repo;
  ExploreCubit({required this.repo}): super(ExploreApiTypes.loadInitialData);
  static ExploreCubit get() => getIt<ExploreCubit>();
  ///load init data
  Future<void> loadInitialData() async {

    fire(ExploreApiTypes.loadInitialData, StateType.loading);


    await Future.wait([
      getSliders(),
      getUnits(),

    ]);




    fire(ExploreApiTypes.loadInitialData, StateType.done);
  }


  /// get Sliders
  List<SliderData>  _slider=[];
  List<SliderData>  get slider=> _slider;
  Future getSliders() async {
    if (_slider.isNotEmpty) {
      printLog("Sliders already loaded. Returning cached data.");
      return;
    }
   await fastFire<SlidersResponse>(
    type: ExploreApiTypes.slider,
    fun: () {
      return repo.getSliders();
    },
    onSuccess: (r) {
     if(r.data != null ){
       _slider=r.data!;
     }
    },
    onFailure: (l) {
      printLog("l is");
      },
  );
  }

  /// get units
  List<UnitsData>  _units=[];
  List<UnitsData>  get units=> _units;
  Future getUnits() async {
    if (_units.isNotEmpty) {
      printLog("units already loaded. Returning cached data.");
      return;
    }
      await fastFire<UnitsResponse>(
    type: ExploreApiTypes.units,
    fun: () {
      return repo.getUnits();
    },
    onSuccess: (r) {
     if(r.data != null){
       _units=r.data!;
     }
    },
    onFailure: (l) {
      printLog("l is");
      },
  );
  }





}


