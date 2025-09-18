
import 'package:flutter/material.dart';

import 'color_resources.dart';



class AppConstants {

  static const double appVersion = 3;
  static const String paginationQuery = "page";
  static String? timezone = '';
  static const String APP_NAME = 'سي عمر';
  static String? fcmToken;
  static  String?  countryCode = 'sa';
  static  String  ar = 'ar';
  static  String   en = 'en';
  static  String   lang = 'ar';
  static const String USER_ID = 'userId';
  static const String NAME = 'name';
  static  String?  countryKey = '';
  static Container dialogHeader(BuildContext context,{required String title,
    double? height,  double? borderRadius,Widget? widget,Function()? onBackPressed}) {
    return Container(
      height:height?? 45,
      width: double.infinity,
      decoration:   BoxDecoration(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(borderRadius??10),topRight: Radius.circular(borderRadius??12) ),

      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon:   const CircleAvatar(
              radius: 10,
              backgroundColor: Color(0xffCBCBCB),
              child: Icon(
                Icons.close,
                color: AppColors.primaryColor,
                size: 18,
              ),
            ),
            onPressed:onBackPressed?? () {
              Navigator.pop(context);
            },
          ),


          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style:   const TextStyle(
                  fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          if(widget !=null)
            widget else
            IconButton(
              icon:   const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.transparent,

              ),
              onPressed: () {

              },
            ),
        ],
      ),
    );
  }
  // sharePreference
  static  String  token = 'token';
  static  String  userId = 'userId';
  static  String  phoneNumber = 'phoneNumber';
  static  String  userName = 'userName';
  static  String  userEmail = 'userEmail';
  static  String  isValidation = 'isValidation';
  static  String  userImage = 'userImage';
  static  String  role = 'role';



}

class LanguageModel {
  String? imageUrl;
  String? languageName;
  String? languageCode;
  String? countryCode;

  LanguageModel({this.imageUrl, this.languageName, this.countryCode, this.languageCode});
}


