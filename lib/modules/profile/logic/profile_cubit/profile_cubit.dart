import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/get_it/get_it.dart';
import '../../../../common/common.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/help_me.dart';
import '../../../../utils/uti.dart';
import '../../domain/models/profile_response.dart';
import '../../domain/models/logout_response.dart';
import '../../domain/request/edit_profile_request.dart';
import '../../domain/services/profile_service.dart';


enum ProfileApiTypes { loadInitialData,getProfile,logout,editProfile}

class ProfileCubit extends BaseCubit<ProfileApiTypes>   {
  final ProfileService  repo;
  ProfileCubit({required this.repo}): super(ProfileApiTypes.loadInitialData);
  static ProfileCubit get() => getIt<ProfileCubit>();

  /// get profile
  Future getProfile({required context, required   Function(ProfileResponse response)? onSuccess }) async {

    return await fastFire<ProfileResponse>(
    type: ProfileApiTypes.getProfile,
    fun: () {
      return repo.getProfile();
    },
    onSuccess: (r) {


      if(r.success ==true) {
        onSuccess?.call(r);
        saveUserData(r.data!);

      }
    },
    onFailure: (l) {
      printLog("l is");


      UTI.showSnackBar(context, l.message, 'error');

    }  ,
  );
  }


  ///save User Data
  Future<void> saveUserData(GetProfileData data ) async {

    try {

      CacheHelper.saveData(key: AppConstants.userName,value: data.name??"");
      CacheHelper.saveData(key: AppConstants.phoneNumber,value: data.phoneNumber??"");
      CacheHelper.saveData(key: AppConstants.USER_ID,value:data.id.toString()??"");


      printLog(CacheHelper.getData(key: AppConstants.token, ));

    } catch (e) {
      rethrow;
    }
  }



  ///logout
  Future logout(

      ) async {
    return   await fastFire<LogoutResponse>(
      type: ProfileApiTypes.logout,
      fun: () {
        return repo.logout();
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

  /// edit profile
  Future  editProfile(
      {required context,required EditProfileRequest editProfile}
      ) async {


    return   await fastFire<ProfileResponse>(
      type: ProfileApiTypes.editProfile,
      fun: () {
        return repo.editProfile(editProfileRequest: editProfile);
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






}


