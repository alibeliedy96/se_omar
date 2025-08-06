import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/helper.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/logic/controllers/theme_provider.dart';
import 'package:mr_omar/models/enum.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';
import '../../models/setting_list_data.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  int selectedradioTile = 0;

  @override
  Widget build(BuildContext context) {
    List<SettingsListData> settingsList = SettingsListData.settingsList;

    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: Loc.alized.setting_text,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: settingsList.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Divider(
                    height: 1,
                  ),
                ),
                itemBuilder: (context, index) {
                  if (index == 1) {
                    return _themeUI(settingsList[index]);
                  }
                  return InkWell(
                    onTap: () {
                      if (index == 6) {

                      } else if (index == 5) {
                        // NavigationServices(context)
                        //     .gotoCountryScreen()
                        //     .then((value) {
                        //   if (value is String && value != "") {
                        //     setState(() {
                        //       country = value;
                        //     });
                        //   }
                        // });
                      } else if (index == 2) {
                        _getFontPopUI();
                      } else if (index == 3) {
                        _getColorPopUI();
                      } else if (index == 4) {
                        _getLanguageUI();
                      } else if (index == 8) {
                        _gotoLoginScreen();
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    settingsList[index].titleTxt,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Icon(
                                              settingsList[index].iconData,
                                              color:
                                                  AppTheme.secondaryTextColor),
                                        )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _themeUI(SettingsListData data) {
    final themeProvider = Get.find<ThemeController>();
    return PopupMenuButton<ThemeModeType>(
      padding: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onSelected: (type) {
        type == ThemeModeType.system
            ? themeProvider.updateThemeMode(ThemeModeType.system)
            : type == ThemeModeType.light
                ? themeProvider.updateThemeMode(ThemeModeType.light)
                : themeProvider.updateThemeMode(ThemeModeType.dark);
        setState(() {});
      },
      offset: const Offset(10, 18),
      itemBuilder: (context) => ThemeModeType.values
          .toList()
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: _getSelectedUI(
                e == ThemeModeType.system
                    ? FontAwesomeIcons.circleHalfStroke
                    : e == ThemeModeType.light
                        ? FontAwesomeIcons.cloudSun
                        : FontAwesomeIcons.cloudMoon,
                e == ThemeModeType.system
                    ? Loc.alized.system
                    : e == ThemeModeType.light
                        ? Loc.alized.light
                        : Loc.alized.dark,
                e == themeProvider.themeModeType,
              ),
            ),
          )
          .toList(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.titleTxt,
              style: TextStyles(context).regular(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                  themeProvider.themeModeType == ThemeModeType.system
                      ? FontAwesomeIcons.circleHalfStroke
                      : themeProvider.themeModeType == ThemeModeType.light
                          ? FontAwesomeIcons.cloudSun
                          : FontAwesomeIcons.cloudMoon,
                  color: AppTheme.secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextUi(String text) {
    return Text(
      text,
      style: TextStyles(context).description().copyWith(
            fontSize: 16,
          ),
    );
  }

  Widget _getSelectedUI(IconData icon, String text, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color:
                isCurrent ? AppTheme.primaryColor : AppTheme.primaryTextColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              text,
              style: TextStyles(context).regular().copyWith(
                    color: isCurrent
                        ? AppTheme.primaryColor
                        : AppTheme.primaryTextColor,
                  ),
            ),
          )
        ],
      ),
    );
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
                Navigator.pop(context);
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
                        TextStyles(context).regular().copyWith(
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
                          TextStyles(context).regular().copyWith(
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
      context: context,
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
              Navigator.pop(context);
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
      context: context,
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
      // const Locale('fr'), // French
      // const Locale('ja'), // Japanises
      const Locale('ar'), // Arebic
    ];
    List<String> languageTexts = ["English", "العربيه"];

    for (var i = 0; i < list.length; i++) {
      final element = list[i];
      languageArray.add(
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Get.find<Loc>().localeLanguage(element);
            Navigator.pop(context);
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
      context: context,
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

  void _gotoLoginScreen() async {
    bool isOk = await Helper.showCommonPopup(
      Loc.alized.are_you_sure,
      Loc.alized.you_want_to_sign_out,
      context,
      barrierDismissible: true,
      isYesOrNoPopup: true,
    );
    if (isOk) {
      // ignore: use_build_context_synchronously
      NavigationServices(context).gotoLoginScreen();
    }
  }
}
