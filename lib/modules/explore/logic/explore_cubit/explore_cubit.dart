import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/get_it/get_it.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';

import '../../../../utils/uti.dart';
import '../../../bottom_tab/bottom_tab_screen.dart';
import '../../domain/models/login_or_register_response.dart';
import '../../domain/request/login_request.dart';
import '../../domain/request/register_request.dart';
import '../../domain/services/explore_service.dart';


enum ExploreApiTypes {  loadInitialData,  login,resendCode,verifyOtp,register }

class ExploreCubit extends BaseCubit<ExploreApiTypes>   {
  final ExploreService  repo;
  ExploreCubit({required this.repo}): super(ExploreApiTypes.loadInitialData);
  static ExploreCubit get() => getIt<ExploreCubit>();

  /// login
  Future login({required LoginRequestModel loginBody,required context }) async {

    return await fastFire<LoginOrRegisterResponse>(
    type: ExploreApiTypes.login,
    fun: () {
      return repo.login(loginBody:loginBody);
    },
    onSuccess: (r) {
      printLog("success   is ${r.message}");

      if(r.success ==true) {



        UTI.showSnackBar(context, r.message, 'success');
        saveUserData(r.data!);
        NavigationServices(context).navigateAndFinish(context, const BottomTabScreen());






      }
    },
    onFailure: (l) {
      printLog("l is");


      UTI.showSnackBar(context, l.message, 'error');

    }  ,
  );
  }


  ///save User Data
  Future<void> saveUserData(LoginOrRegisterData data ) async {

    try {
      CacheHelper.saveData(key: AppConstants.token,value: data.token??"");
      CacheHelper.saveData(key: AppConstants.userName,value: data.user?.name??"");
      CacheHelper.saveData(key: AppConstants.phoneNumber,value: data.user?.phoneNumber??"");
      CacheHelper.saveData(key: AppConstants.USER_ID,value:data.user?.id.toString()??"");


      printLog(CacheHelper.getData(key: AppConstants.token, ));

    } catch (e) {
      rethrow;
    }
  }


  /// register
  Future  registerUser(
  {required context,required RegisterRequest register}
 ) async {


    return   await fastFire<LoginOrRegisterResponse>(
      type: ExploreApiTypes.register,
      fun: () {
        return repo.registerUser(register: register);
      },
      onSuccess: (r) {
        if(r.success ==true) {
          UTI.showSnackBar(context, r.message, 'success');

          saveUserData(r.data!);
          NavigationServices(context).navigateAndFinish(context, const BottomTabScreen());
        }
      },
      onFailure: (l) {
        UTI.showSnackBar(context, l.message, 'error');
        printLog("error   is ${l.message}");
      },
    );

  }




}


