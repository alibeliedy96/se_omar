import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mr_omar/common/common.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/logic/controllers/theme_provider.dart';
import 'package:mr_omar/main.dart';
import 'package:mr_omar/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:mr_omar/modules/login/view/login/login_screen.dart';
import 'package:mr_omar/modules/splash/introduction_screen.dart';
import 'package:mr_omar/modules/splash/splash_screen.dart';
import 'package:mr_omar/routes/routes.dart';

import 'l10n/app_localization.dart';

class MotelApp extends StatefulWidget {
  const MotelApp({Key? key}) : super(key: key);

  @override
  State<MotelApp> createState() => _MotelAppState();
}

class _MotelAppState extends State<MotelApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (_) {
        final ThemeData theme = AppTheme.getThemeData;
        return GetBuilder<Loc>(
          builder: (locController) {
            return GetMaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: const [
                Locale('en'), // English
                // Locale('fr'), // French
                // Locale('ja'), // Japanises
                Locale('ar'), // Arebic
              ],
              navigatorKey: navigatorKey,
              locale: locController.locale,
              title: 'سي عمر',
              debugShowCheckedModeBanner: false,
              theme: theme,
              routes: _buildRoutes(),
              initialBinding: AppBinding(),
              builder: (BuildContext context, Widget? child) {
                _setFirstTimeSomeData(context, theme);
                return Directionality(
                  textDirection: locController.locale.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: MediaQuery(
                    key: ValueKey(
                        'languageCode ${locController.locale.languageCode}'),
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(
                          MediaQuery.of(context).size.width > 360
                              ? 1.0
                              : MediaQuery.of(context).size.width >= 340
                                  ? 0.9
                                  : 0.8),
                    ),
                    child: child ?? const SizedBox(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

// when this application open every time on that time we check and update some theme data
  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    _setStatusBarNavigationBarTheme(theme);
    //we call some theme basic data set in app like color, font, theme mode, language
    Get.find<ThemeController>()
        .checkAndSetThemeMode(MediaQuery.of(context).platformBrightness);
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.colorScheme.background,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.splash: (BuildContext context) => const SplashScreen(),
      RoutesName.introductionScreen: (BuildContext context) =>
          const IntroductionScreen(),
      RoutesName.home: (BuildContext context) => const BottomTabScreen(),
      RoutesName.login: (BuildContext context) => const LoginScreen(),
    };
  }

}
