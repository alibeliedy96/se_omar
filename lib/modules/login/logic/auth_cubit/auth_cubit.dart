 import 'package:flutter/material.dart';

import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/get_it/get_it.dart';
import '../../../../common/common.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';

import '../../../../utils/uti.dart';
import '../../../bottom_tab/bottom_tab_screen.dart';
import '../../domain/models/login_or_register_response.dart';
import '../../domain/models/logout_response.dart';

import '../../domain/request/login_request.dart';
import '../../domain/request/register_request.dart';
import '../../domain/services/auth_service.dart';


enum AuthApiTypes { getCountries,getCities,loadInitialData,getNationalities,getLanguages , login,resendCode,verifyOtp,register,registerAdvisor,logout,deleteAccount}

class AuthCubit extends BaseCubit<AuthApiTypes>   {
  final AuthService  repo;
  AuthCubit({required this.repo}): super(AuthApiTypes.loadInitialData);
  static AuthCubit get() => getIt<AuthCubit>();

  /// login
  Future login({required LoginRequestModel loginBody,required context }) async {

    return await fastFire<LoginOrRegisterResponse>(
    type: AuthApiTypes.login,
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



  ///logout
  Future logout(

      ) async {
    return   await fastFire<LogoutResponse>(
      type: AuthApiTypes.deleteAccount,
      fun: () {
        return repo.deleteAccount();
      },
      onSuccess: (r) {
        UTI.showSnackBar(navigatorKey.currentContext!,  r.message ,"success");
        CacheHelper.removeData(key: AppConstants.token);
        CacheHelper.removeData(key: AppConstants.userId);
        CacheHelper.removeData(key: AppConstants.userEmail);
        CacheHelper.removeData(key: AppConstants.userName);
        CacheHelper.removeData(key: AppConstants.role);


      },
      onFailure: (l) {

        UTI.showSnackBar(navigatorKey.currentContext!, l.message, 'error');
      },
    );

  }


  /// register
  Future  registerUser(
  {required context,required RegisterRequest register}
 ) async {


    return   await fastFire<LoginOrRegisterResponse>(
      type: AuthApiTypes.register,
      fun: () {
        return repo.registerUser(register: register);
      },
      onSuccess: (r) {
        if(r.success ==true) {
          UTI.showSnackBar(context, r.message, 'success');

          saveUserData(r.data!);

        }
      },
      onFailure: (l) {
        UTI.showSnackBar(context, l.message, 'error');
        printLog("error   is ${l.message}");
      },
    );

  }
  /// deleteAccount
  Future  deleteAccount({ required context }) async {
    return   await fastFire<LogoutResponse>(
      type: AuthApiTypes.deleteAccount,
      fun: () {
        return repo.deleteAccount();
      },
      onSuccess: (r) {
        if (r.status == 200) {
          UTI.showSnackBar(navigatorKey.currentContext!,  r.message ,"success");
          CacheHelper.removeData(key: AppConstants.token);
          CacheHelper.removeData(key: AppConstants.userId);
          CacheHelper.removeData(key: AppConstants.userEmail);
          CacheHelper.removeData(key: AppConstants.userName);
          CacheHelper.removeData(key: AppConstants.role);
          // HomeMainCubit.get(navigatorKey.currentContext!).index=0;
          // AppNavigation.navigateAndFinishWithRoute(navigatorKey.currentContext!, routeScreen: Routes.mainHomeScreen);

        }
      },
      onFailure: (l) {

        UTI.showSnackBar(context, l.message, 'error');
      },
    );

  }



}


