
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../main.dart';
import '../../utils/color_resources.dart';

enum ToastType {
  success,
  error,
  info,
  warning,
}

class AppSnackBar {
  AppSnackBar._();

  static void show(String? message, {BuildContext? context, ToastType? type}) {
    if (message == null) return;
    context ??= Get.context!;

    Color bgColor = switch (type) {
      ToastType.success || null => AppColors.success,
      ToastType.info => AppColors.info,
      ToastType.error => AppColors.error,
      ToastType.warning => AppColors.warning,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }
}
