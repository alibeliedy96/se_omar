import 'package:flutter_dotenv/flutter_dotenv.dart';
class EndPoints {


   // static const String baseUrl = 'https://backend-live.malathapp.com';
   static final String baseUrl = dotenv.env['BASE_URL']!;


  static const fields = "/fields/basic-fields";
  static const advisorAppointments = "/appointments/my-appointments/grouped-by-day";
  static const GET_CONSULTANT = "/users/advisers";
  static const bookSession = "/sessions/book";
  static const checkDiscountCoupon = "/coupons/check-discount";
  static String deleteAppointment(int appointmentId) {
     return '/appointments/$appointmentId';
   }
   static String companiesByAdvisorId(int advisorId) {
     return '/companies/by-adviser/$advisorId';
   }
   static String showAdvisorAppointments(String advisorId, {String? couponCode}) {
    final url =couponCode==null?'/appointments/adviser/$advisorId/grouped-by-day':'/appointments/adviser/$advisorId/grouped-by-day?couponCode=$couponCode';
     return url;
   }
   static String companyCouponsCode(String code) {
     return '/company-coupons/validate/$code';
   }
   static String companyCouponsAdvisor(String code) {
     return '/company-coupons/check/$code/advisers';
   }
  static const createAppointments = "/appointments";
  static const  notifications = "/notifications/my-notifications";
  static const lectures = "/api/v1/lectures";
   static const String consultantDetails = '/users/';
   static const String policies = '/api/v1/constants/';
     static const String GET_SEESIONS = '/sessions/my-sessions';
     static const String rateAdvisor = '/ratings';

   static String getSessionDetailsUrl(String sessionId) {
     return '/sessions/$sessionId';
   }
   static String joinMeeting(String sessionId) {
     return '/sessions/$sessionId/join-meeting';
   }
   static String cancelSession(String sessionId) {
     return '/sessions/$sessionId/cancel';
   }
   static String endMeeting(String sessionId) {
     return '/sessions/$sessionId/end-session';
   }
   static String updateRatingAdvisor(String advisorId) {
     return '/ratings/my-rating/adviser/$advisorId';
   }
   static String getMyRatingsAdvisorUrl(String advisorId) {
     return '/ratings/my-rating/adviser/$advisorId';
   }
   static String getCities(int countryId) {
     return '/locations/countries/$countryId/cities';
   }
   static String updateAvatarOrVideo(int userId,type) {
     return '/users/$userId/$type';
   }
   static const String REGISTRATION_URI = '/auth/register';
   static const String LOGIN_URI = '/api/login';
   static const String LOGOUT_URI = '/api/v1/auth/signout';
   static const String OTP_VERIFY_URI = '/auth/whatsapp/verify';
   static const String aiAssistant = '/api/v1/ai-assistant/assistants';
   static const String aiChatDetails = '/api/v1/ai-assistant/chats/';
   static const String aiAssistantSendMessageChat = '/ai-assistant/completion';
   static const String profile = '/auth/profile';
   static const String countries = '/locations/countries';
   static const String nationalities = '/nationalities';
   static const String languages = '/languages';
   static const String deleteAccount = '/api/v1/auth/removeAccount';
}
