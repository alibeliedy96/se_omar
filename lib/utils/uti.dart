

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../core/api/shared/shared_methods.dart';
import '../core/base/costom_404.dart';


class UTI {
  UTI._();

  static Size? size;

  static Widget backIcon() => const Icon(Icons.arrow_back_ios);



  static Custom404 errorWidget(
      {double imageHeight = 200.0,
      double textFontSize = 16,
      String? imagePath,String? title,String? text,}) {
    return Custom404(
      imagePath: imagePath,
      imageHeight: imageHeight,
      textFontSize: textFontSize,
      btnTxt: "اعادة المحاوله",
      onTap: () {},
      text: text??"",
      title:title?? "لا توجد بيانات",
    );
  }

  static showSnackBar(context, message, status) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: status == 'error' ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future showToast(
      {required String msg,
      bool? toastState,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: toastState != null
          ? toastState
              ? Colors.yellow[900]
              : Colors.red
          : Colors.green,
    );
  }

  static Widget unFocus({Widget? child}) =>
      GestureDetector(onTap: unFocusKeyboard, child: child);




}
