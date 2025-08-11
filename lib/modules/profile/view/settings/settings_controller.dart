// File: settings_controller.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/helper.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/logic/controllers/theme_provider.dart';
import 'package:mr_omar/routes/route_names.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../utils/app_constants.dart';
import '../../logic/profile_cubit/profile_cubit.dart';


/// Controller for the SettingsScreen.
/// Manages all UI logic, dialogs, and navigation.
class SettingsController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final ThemeController _themeController = Get.find<ThemeController>();
  final Loc _loc = Get.find<Loc>();
  final ProfileCubit _profileCubit = ProfileCubit.get();

  // ==========================
  //      Public Methods
  // ==========================

  /// Handles tap on a list item and navigates or shows a dialog accordingly.
  void onSettingsItemTapped(BuildContext context, int index) async {
    switch (index) {
      case 0:
        NavigationServices(context).gotoChangepasswordScreen();
        break;
      case 1:
        NavigationServices(context).gotoHeplCenterScreen();
        break;
      case 2:
        _showFontDialog(context);
        break;
      case 3:
        _showColorDialog(context);
        break;
      case 4:
        _showLanguageDialog(context);
        break;
      case 8: // Assuming Logout is at index 8
        await logoutOrLogin(context);
        break;
    // Add other cases as needed
    }
  }

  /// Shows the theme selection popup (logic extracted from the view).
  PopupMenuButton<ThemeModeType> buildThemePopupMenu(BuildContext context) {
    return PopupMenuButton<ThemeModeType>(
      padding: EdgeInsets.zero,
      onSelected: (type) {
        _themeController.updateThemeMode(type);
        notifyListeners(); // Notify UI to update the icon
      },
      itemBuilder: (context) => ThemeModeType.values.map((e) {
        return PopupMenuItem(
          value: e,

          child: _buildPopupMenuItem(
            icon: e == ThemeModeType.system ? FontAwesomeIcons.circleHalfStroke : (e == ThemeModeType.light ? FontAwesomeIcons.cloudSun : FontAwesomeIcons.cloudMoon),
            text: e == ThemeModeType.system ? Loc.alized.system : (e == ThemeModeType.light ? Loc.alized.light : Loc.alized.dark),
            isCurrent: e == _themeController.themeModeType,
          ),
        );
      }).toList(),
      child: _buildThemeDisplay(context),
    );
  }

  /// Logs the user out after confirmation.
  Future<void> logoutOrLogin(BuildContext context) async {
    final token = await CacheHelper.getData(key: AppConstants.token);
    if(token==null){
      NavigationServices(Get.context!).gotoLoginScreen();
    }else{
      bool? didConfirm = await Helper.showCommonPopup(
        Loc.alized.are_you_sure,
        Loc.alized.you_want_to_sign_out,
        context,
        barrierDismissible: true,
        isYesOrNoPopup: true,
      );
      if (didConfirm == true) {
        await _profileCubit.logout();
        NavigationServices(Get.context!).gotoLoginScreen();
      }
    }

  }

  // --- Private helper methods for building UI parts of dialogs ---

  void _showFontDialog(BuildContext context) {
    // Logic from _getFontPopUI
  }
  void _showColorDialog(BuildContext context) {
    // Logic from _getColorPopUI
  }
  void _showLanguageDialog(BuildContext context) {
    // Logic from _getLanguageUI
  }

  Widget _buildThemeDisplay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(Loc.alized.theme_mode, style: TextStyles(context).regular()),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              _themeController.themeModeType == ThemeModeType.system
                  ? FontAwesomeIcons.circleHalfStroke
                  : _themeController.themeModeType == ThemeModeType.light
                  ? FontAwesomeIcons.cloudSun
                  : FontAwesomeIcons.cloudMoon,
              color: AppTheme.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenuItem({
    required IconData icon,
    required String text,
    required bool isCurrent,
  }) {
    return Row(
      children: [
        Icon(icon, color: isCurrent ? AppTheme.primaryColor : AppTheme.primaryTextColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(text, style: TextStyle(color: isCurrent ? AppTheme.primaryColor : AppTheme.primaryTextColor)),
        )
      ],
    );
  }
}