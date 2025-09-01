import 'package:flutter_dotenv/flutter_dotenv.dart';
class EndPoints {


   // static const String baseUrl = 'https://backend-live.malathapp.com';
   static final String baseUrl = dotenv.env['BASE_URL']!;

   static const String REGISTRATION_URI = '/api/register';
   static const String LOGIN_URI = '/api/login';
   static const String sliders = '/api/sliders';
   static const String settings = '/api/settings';
   static const String search = '/api/search/units?q=';
   static String unitDetails(String unitId) {
      return '/api/units/$unitId';
   }
   static const String units = '/api/units';
   static const String reservations = '/api/reservations';
   static const String bulkPricing = '/api/reservations/bulk-pricing';
   static const String createReservations = '/api/reservations';
   static const String forgotPassword = '/api/forgot-password';
   static const String profile = '/api/profile';
   static const String changePassword = '/api/change-password';
   static const String logout = '/api/logout';
   static const String deleteAccount = '/api/v1/auth/removeAccount';
}
