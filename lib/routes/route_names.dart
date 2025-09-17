import 'package:flutter/material.dart';
import 'package:mr_omar/models/hotel_list_data.dart';
import 'package:mr_omar/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:mr_omar/modules/hotel_booking/filter_screen/filters_screen.dart';
import 'package:mr_omar/modules/hotel_booking/hotel_home_screen.dart';
import 'package:mr_omar/modules/profile/view/change_password/change_password.dart';
import 'package:mr_omar/modules/login/view/login/login_screen.dart';
import 'package:mr_omar/modules/profile/view/edit_profile/edit_profile.dart';
import 'package:mr_omar/modules/profile/view/how_do_screen.dart';
import 'package:mr_omar/modules/unit_details/domain/models/unit_details_response.dart';
import 'package:mr_omar/routes/routes.dart';

import '../modules/choose_available_days_to_book/domain/models/bulk_pricing_response.dart';
import '../modules/choose_available_days_to_book/presentation/view/booking_summary_screen.dart';
import '../modules/choose_available_days_to_book/presentation/view/choose_available_days_screen.dart';
import '../modules/profile/view/settings/terms_and_privcy_screen.dart';
import '../modules/unit_details/view/unit_details.dart';
import '../modules/unit_details/reviews_list_screen.dart';
import '../modules/unit_details/room_booking_screen.dart';
import '../modules/search/presentation/view/search_screen.dart';
import '../modules/login/view/forgot_password/forgot_password.dart';
import '../modules/login/view/register/sign_up_Screen.dart';
import '../modules/profile/view/hepl_center_screen.dart';
import '../modules/profile/view/settings/settings_screen.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }
    void navigateAndFinish(BuildContext? context, widget) {


    Navigator.pushAndRemoveUntil(
      context!,
      MaterialPageRoute(builder: (BuildContext context) => widget),
          (Route<dynamic> route) => false,
    );
  }

  Future gotoSplashScreen() async {
    await Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.splash, (Route<dynamic> route) => false);
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.introductionScreen,
        (Route<dynamic> route) => false);
  }

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(const LoginScreen());
  }

  Future<dynamic> gotoTabScreen() async {
    return await _pushMaterialPageRoute(const BottomTabScreen());
  }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(const SignUpScreen());
  }

  Future<dynamic> gotoForgotPassword() async {
    return await _pushMaterialPageRoute(const ForgotPasswordScreen());
  }

  Future<dynamic> gotoHotelDetails({required String unitId,   bool? isFinished}) async {
    return await _pushMaterialPageRoute(HotelDetails(
      unitId: unitId,
        isFinished:isFinished
    ));
  }

  Future<dynamic> gotoSearchScreen({required String searchKey}) async {
    return await _pushMaterialPageRoute(  SearchScreen(searchKey: searchKey,));
  }

  // Future<dynamic> gotoHotelHomeScreen() async {
  //   return await _pushMaterialPageRoute(const HotelHomeScreen());
  // }

  Future<dynamic> gotoFiltersScreen() async {
    return await _pushMaterialPageRoute(const FiltersScreen());
  }

  Future<dynamic> gotoRoomBookingScreen(String hotelname) async {
    return await _pushMaterialPageRoute(
        RoomBookingScreen(hotelName: hotelname));
  }

  Future<dynamic> gotoReviewsListScreen() async {
    return await _pushMaterialPageRoute(const ReviewsListScreen());
  }

  Future<dynamic> gotoEditProfile() async {
    return await _pushMaterialPageRoute(const EditProfile());
  }
  Future<dynamic> gotoBookScreen({required UnitDetailsData unit}) async {
    return await _pushMaterialPageRoute(  ChooseTimeScreen(unit:unit ));
  }

  Future<dynamic> gotoBookingSummaryScreen({required BulkPricingResponse response}) async {
    return await _pushMaterialPageRoute(  BookingSummaryScreen(pricingData:response ));
  }

  Future<dynamic> gotoSettingsScreen() async {
    return await _pushMaterialPageRoute(const SettingsScreen());
  }

  Future<dynamic> gotoHeplCenterScreen() async {
    return await _pushMaterialPageRoute(const HelpCenterScreen());
  }

  Future<dynamic> gotoChangepasswordScreen() async {
    return await _pushMaterialPageRoute(const ChangePasswordScreen());
  }
  Future<dynamic> goToTermsAndPrivacyScreen({required String title, required String content}) async {
    return await _pushMaterialPageRoute(  TermsAndPrivacyScreen(title:title ,content:content));
  }


  Future<dynamic> gotoHowDoScreen() async {
    return await _pushMaterialPageRoute(const HowDoScreen());
  }

//   void gotoHotelDetailesPage(String hotelname) async {
//     await _pushMaterialPageRoute(HotelDetailes(hotelName: hotelname));
//   }
}
