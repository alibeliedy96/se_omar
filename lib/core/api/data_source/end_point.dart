import 'package:flutter_dotenv/flutter_dotenv.dart';
class EndPoints {


   // static const String baseUrl = 'https://backend-live.malathapp.com';
   static final String baseUrl = dotenv.env['BASE_URL']!;

   static const String REGISTRATION_URI = '/api/register';
   static const String LOGIN_URI = '/api/login';
   static const String profile = '/api/profile';
   static const String logout = '/api/logout';
   static const String deleteAccount = '/api/v1/auth/removeAccount';
}
