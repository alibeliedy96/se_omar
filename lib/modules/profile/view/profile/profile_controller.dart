// File: profile_controller.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/routes/route_names.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../utils/app_constants.dart';
import '../../domain/models/profile_response.dart';
import '../../logic/profile_cubit/profile_cubit.dart';


/// Controller for the ProfileScreen.
/// Manages state and business logic for the user profile.
class ProfileController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final ProfileCubit _cubit = ProfileCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  GetProfileData? _profileData;
  bool _isLoading = true;
  bool _isLoggedIn = false;

  // ==========================
  //      Public Getters
  // ==========================
  GetProfileData? get profileData => _profileData;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  // ==========================
  //      Initialization
  // ==========================
  void init(BuildContext context) async {

    final token = await CacheHelper.getData(key: AppConstants.token);
    _isLoggedIn = token != null;

    fetchProfile(context);
  }

  // ==========================
  //      Public Methods
  // ==========================

  /// Fetches the user profile from the API.
  Future<void> fetchProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (_isLoggedIn) {
      await _cubit.getProfile(
        onSuccess: (response) {
          _profileData = response.data;
        },
        context: context,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Handles tap on a list item and navigates accordingly.
  void onSettingsItemTapped(BuildContext context, int index) {
    if (_isLoggedIn) {
      switch (index) {
      case 0:
        goToChangePassword(context);
        break;
      case 1:
        goToHelpCenter(context);
        break;
      case 2:
        goToSettings(context);
        break;
    }
    }else{
      switch (index) {
        case 0:
          goToHelpCenter(context);
          break;
        // case 1:
        //   goToHelpCenter(context);
        //  break;
        case 1:
          goToSettings(context);
          break;
      }
    }
  }

  /// Navigation methods
  void goToEditProfile(BuildContext context) {
    if (_isLoggedIn) {
      NavigationServices(context).gotoEditProfile();
    } else {
      NavigationServices(context).gotoLoginScreen();
    }
  }

  void goToChangePassword(BuildContext context) {
    NavigationServices(context).gotoChangepasswordScreen();
  }

  void goToHelpCenter(BuildContext context) {
    NavigationServices(context).gotoHeplCenterScreen();
  }

  void goToSettings(BuildContext context) {
    NavigationServices(context).gotoSettingsScreen();
  }
}
