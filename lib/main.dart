import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/logic/controllers/google_map_pin_controller.dart';
import 'package:mr_omar/logic/controllers/theme_provider.dart';
import 'package:mr_omar/motel_app.dart';
final langCode = Localizations.localeOf(Get.context!).languageCode;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<Loc>(() => Loc().init(), permanent: true);

  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MotelApp()));
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleMapPinController>(GoogleMapPinController());
  }
}
