import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/logic/controllers/google_map_pin_controller.dart';
import 'package:mr_omar/logic/controllers/theme_provider.dart';
import 'package:mr_omar/si_omar_app.dart';
import 'package:mr_omar/utils/app_constants.dart';
import 'package:mr_omar/utils/help_me.dart';
import 'package:mr_omar/utils/uti.dart';

import 'core/api/dio_helper.dart';
import 'core/get_it/get_it.dart';
import 'core/notification_helper/messaging.dart';
final langCode = Localizations.localeOf(Get.context!).languageCode;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  DioHelper.init();
  if (!kIsWeb) {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }


    try {
      await FirebaseMessaging.instance.requestPermission();
      await Messaging.initFCM();
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        AppConstants.fcmToken = token;
        printLog("FCM token: ${AppConstants.fcmToken}");
      } else {
        printLog("FCM token is null.");
      }
    } catch (e) {
      printLog("Error while fetching FCM token: $e");
    }

  }


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
