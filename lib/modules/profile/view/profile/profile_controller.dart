// File: profile_controller.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/routes/route_names.dart';
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

  // ==========================
  //      Public Getters
  // ==========================
  GetProfileData? get profileData => _profileData;
  bool get isLoading => _isLoading;

  // ==========================
  //      Initialization
  // ==========================
  void init(BuildContext context) {
    fetchProfile(context);
  }

  // ==========================
  //      Public Methods
  // ==========================

  /// Fetches the user profile from the API.
  Future<void> fetchProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners();


    await _cubit.getProfile(onSuccess: (response) {
      _profileData = response.data;
    }, context: context);

    _isLoading = false;
    notifyListeners();
  }

  /// Handles tap on a list item and navigates accordingly.
  void onSettingsItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        goToChangePassword(context);
        break;
      case 1:
        goToHelpCenter(context);
        break;
      case 3:
        goToSettings(context);
        break;
    // Add other cases as needed
    }
  }

  /// Navigation methods, keeping the View clean.
  void goToEditProfile(BuildContext context) {
    NavigationServices(context).gotoEditProfile();
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