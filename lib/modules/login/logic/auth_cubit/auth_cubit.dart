import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/get_it/get_it.dart';
import '../../../../routes/route_names.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';

import '../../../../utils/uti.dart';
import '../../../bottom_tab/bottom_tab_screen.dart';
import '../../domain/models/forgot_password_response.dart';
import '../../domain/models/login_or_register_response.dart';
import '../../domain/models/settings_response.dart';
import '../../domain/request/login_request.dart';
import '../../domain/request/register_request.dart';
import '../../domain/services/auth_service.dart';


enum AuthApiTypes {  loadInitialData,  login,forgotPassword,getSettings,resendCode,verifyOtp,register }

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
      CacheHelper.saveData(key: AppConstants.userEmail,value: data.user?.email??"");
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
      type: AuthApiTypes.register,
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

  /// forgot password
  Future forgotPassword({required String email,required context }) async {

    return await fastFire<ForgotPasswordResponse>(
      type: AuthApiTypes.forgotPassword,
      fun: () {
        return repo.forgotPassword(email:email);
      },
      onSuccess: (r) {
        printLog("success   is ${r.message}");

        if(r.success ==true) {
          UTI.showSnackBar(context, r.message, 'success');
        }
      },
      onFailure: (l) {
        printLog("l is");
        UTI.showSnackBar(context, l.message, 'error');

      }  ,
    );
  }
  SettingsData? settingData;
  Future<void> getSettings({ required context }) async {
    await  fastFire<SettingsResponse>(
      type: AuthApiTypes.getSettings,
      fun: repo.getSettings,
      onSuccess: (r) {
        if (r.data != null) {
          settingData=r.data;
          NavigationServices(context).navigateAndFinish(context, const BottomTabScreen());
          // String? minimumVersionString;
          // if (Platform.isAndroid) {
          //   minimumVersionString = r.data?.androidVersion;
          //
          // }
          // else if (Platform.isIOS) {
          //   minimumVersionString = r.data?.iosVersion;
          //
          // }
          // try {
          //   final currentVersion = Version.parse(normalizeVersionString(AppConstants.appVersion));
          //   final minRequiredVersion = Version.parse(normalizeVersionString(minimumVersionString));
          //
          //   if (currentVersion < minRequiredVersion ) {
          //     showUpdateBottomSheet();
          //     return;
          //   }else{
          //     _route();
          //   }
          // } catch (e) {
          //   print("Version parsing error: $e");
          // }
        }
      },
    );

  }

}


