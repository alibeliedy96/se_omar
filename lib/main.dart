import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/logic/controllers/google_map_pin_controller.dart';
import 'package:mr_omar/logic/controllers/theme_provider.dart';
import 'package:mr_omar/si_omar_app.dart';

import 'core/api/dio_helper.dart';
import 'core/get_it/get_it.dart';
final langCode = Localizations.localeOf(Get.context!).languageCode;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  DioHelper.init();
  await Get.putAsync<Loc>(() => Loc().init(), permanent: true);
  await setupGetIt();
  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const SiOmarApp()));
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleMapPinController>(GoogleMapPinController());
  }
}
