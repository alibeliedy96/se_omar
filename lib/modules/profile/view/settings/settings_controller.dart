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
import '../../../../models/enum.dart';
import '../../../../utils/app_constants.dart';
import '../../../../widgets/common_card.dart';
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
        // NavigationServices(context).gotoChangepasswordScreen();
        break;
      case 1:
        // NavigationServices(context).gotoHeplCenterScreen();
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
     _getFontPopUI();
  }
  void _showColorDialog(BuildContext context) {
    _getColorPopUI();
  }
  void _showLanguageDialog(BuildContext context) {
    _getLanguageUI();
  }
  _getFontPopUI() {
    final List<Widget> fontArray = [];
    FontFamilyType.values.toList().forEach(
          (element) {
        fontArray.add(
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                Get.find<ThemeController>().updateFontType(element);
                Navigator.pop(Get.context!);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello",
                      style: AppTheme.getTextStyle(
                        element,
                        TextStyles(Get.context!).regular().copyWith(
                            color:
                            Get.find<ThemeController>().fontType == element
                                ? AppTheme.primaryColor
                                : AppTheme.fontcolor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: FontFamilyType.workSans == element ? 3 : 0),
                      child: Text(
                        element.toString().split('.')[1],
                        style: AppTheme.getTextStyle(
                          element,
                          TextStyles(Get.context!).regular().copyWith(
                              color: Get.find<ThemeController>().fontType ==
                                  element
                                  ? AppTheme.primaryColor
                                  : AppTheme.fontcolor),
                        ).copyWith(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      Loc.alized.selected_fonts,
                      style: TextStyles(context).bold().copyWith(fontSize: 22),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            fontArray[0],
                            fontArray[1],
                            fontArray[2],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            fontArray[3],
                            fontArray[4],
                            fontArray[5],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getColorPopUI() {
    final List<Widget> fontArray = [];

    ColorType.values.toList().forEach((element) {
      fontArray.add(
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              Get.find<ThemeController>().updateColorType(element);
              Navigator.pop(Get.context!);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                            Get.find<ThemeController>().colorType == element
                                ? AppTheme.getColor(element)
                                : Colors.transparent)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.getColor(element)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
    return showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      Loc.alized.selected_color,
                      style: TextStyles(context).bold().copyWith(fontSize: 22),
                    ),
                  ),
                  const Divider(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        fontArray[0],
                        fontArray[1],
                        fontArray[2],
                        fontArray[3]
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getLanguageUI() {
    final List<Widget> languageArray = [];
    final list = [
      const Locale('en'), // English

      const Locale('ar'), // Arebic
    ];
    List<String> languageTexts = ["English",   "Arabic"];

    for (var i = 0; i < list.length; i++) {
      final element = list[i];
      languageArray.add(
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Get.find<Loc>().localeLanguage(element);
            Navigator.pop(Get.context!);
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, bottom: 16, top: 16, right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Get.find<Loc>().locale == element
                    ? const Icon(Icons.radio_button_checked)
                    : const Icon(Icons.radio_button_off),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Text(languageTexts[i]),
                )
              ],
            ),
          ),
        ),
      );
    }

    return showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 240,
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                    child: Text(
                      Loc.alized.selected_language,
                      style: TextStyles(context).bold().copyWith(fontSize: 22),
                    ),
                  ),
                  const Divider(
                    height: 16,
                  ),
                  for (var item in languageArray) item,
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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