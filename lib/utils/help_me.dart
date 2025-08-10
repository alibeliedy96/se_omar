import 'package:flutter/foundation.dart';

const kLogTag = "[si omar]";
const kLogEnable = true;
DateTime? loginClickTime;

printLog(dynamic data) {
  if (kLogEnable) {
    if (kDebugMode) {
      print("$kLogTag${data.toString()}");
    }
  }
}

bool isRedundentClick(DateTime currentTime){
  if(loginClickTime==null){
    loginClickTime = currentTime;
    return false;
  }
  if(currentTime.difference(loginClickTime!).inSeconds<3){
    return true;
  }

  loginClickTime = currentTime;
  return false;
}
