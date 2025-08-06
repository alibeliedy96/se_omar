import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_ar.dart';
import 'app_localization_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @best_hotel_deals.
  ///
  /// In en, this message translates to:
  /// **'Best hotel deals for your holiday'**
  String get best_hotel_deals;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have account? Log in'**
  String get already_have_account;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get get_started;

  /// No description provided for @plan_your_trips.
  ///
  /// In en, this message translates to:
  /// **'Plan your trips'**
  String get plan_your_trips;

  /// No description provided for @book_one_of_your.
  ///
  /// In en, this message translates to:
  /// **'book one of your unique hotel to\nescape the ordinary'**
  String get book_one_of_your;

  /// No description provided for @find_best_deals.
  ///
  /// In en, this message translates to:
  /// **'Find best deals'**
  String get find_best_deals;

  /// No description provided for @find_deals_for_any.
  ///
  /// In en, this message translates to:
  /// **'Find deals for any season from cosy\ncountry homes to city flats'**
  String get find_deals_for_any;

  /// No description provided for @best_travelling_all_time.
  ///
  /// In en, this message translates to:
  /// **'Best travelling all time'**
  String get best_travelling_all_time;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account;

  /// No description provided for @log_with_mail.
  ///
  /// In en, this message translates to:
  /// **'or log in with email'**
  String get log_with_mail;

  /// No description provided for @your_mail.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get your_mail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_your_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your Password?'**
  String get forgot_your_password;

  /// No description provided for @resend_email_link.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive an email to reset your password'**
  String get resend_email_link;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @enter_your_phone.
  ///
  /// In en, this message translates to:
  /// **'enter your phone'**
  String get enter_your_phone;

  /// No description provided for @your_phone.
  ///
  /// In en, this message translates to:
  /// **'your phone'**
  String get your_phone;

  /// No description provided for @enter_valid_phone.
  ///
  /// In en, this message translates to:
  /// **'enter valid phone'**
  String get enter_valid_phone;

  /// No description provided for @phone_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'phone cannot empty'**
  String get phone_cannot_empty;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get last_name;

  /// No description provided for @terms_agreed.
  ///
  /// In en, this message translates to:
  /// **'By Signing up,you agreed with our terms of\n Services and privacy policy'**
  String get terms_agreed;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @where_are_you_going.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get where_are_you_going;

  /// No description provided for @search_hotel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_hotel;

  /// No description provided for @hotel_data.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotel_data;

  /// No description provided for @backpacker_data.
  ///
  /// In en, this message translates to:
  /// **'Backpacker'**
  String get backpacker_data;

  /// No description provided for @resort_data.
  ///
  /// In en, this message translates to:
  /// **'Resort'**
  String get resort_data;

  /// No description provided for @villa_data.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get villa_data;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @guest_house.
  ///
  /// In en, this message translates to:
  /// **'Guest house'**
  String get guest_house;

  /// No description provided for @motel.
  ///
  /// In en, this message translates to:
  /// **'Motel'**
  String get motel;

  /// No description provided for @accommodation.
  ///
  /// In en, this message translates to:
  /// **'Accommodation'**
  String get accommodation;

  /// No description provided for @bed_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Bed & Breakfast'**
  String get bed_breakfast;

  /// No description provided for @last_search.
  ///
  /// In en, this message translates to:
  /// **'Last searches'**
  String get last_search;

  /// No description provided for @clear_all.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clear_all;

  /// No description provided for @cape_town.
  ///
  /// In en, this message translates to:
  /// **'Cape Town'**
  String get cape_town;

  /// No description provided for @five_star.
  ///
  /// In en, this message translates to:
  /// **'Extraordinary five-star\noutdoor activites'**
  String get five_star;

  /// No description provided for @view_hotel.
  ///
  /// In en, this message translates to:
  /// **'View Hotel'**
  String get view_hotel;

  /// No description provided for @hotel_found.
  ///
  /// In en, this message translates to:
  /// **'Hotel Found'**
  String get hotel_found;

  /// No description provided for @filtter.
  ///
  /// In en, this message translates to:
  /// **'Filtter'**
  String get filtter;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'NO'**
  String get no;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'YES'**
  String get yes;

  /// No description provided for @enter_the_discount_code.
  ///
  /// In en, this message translates to:
  /// **'Enter the discount code'**
  String get enter_the_discount_code;

  /// No description provided for @please_enter_the_discount_code.
  ///
  /// In en, this message translates to:
  /// **'Please enter the discount code'**
  String get please_enter_the_discount_code;

  /// No description provided for @discount_code.
  ///
  /// In en, this message translates to:
  /// **'Discount code'**
  String get discount_code;

  /// No description provided for @choose_from_the_available_days.
  ///
  /// In en, this message translates to:
  /// **'Choose from the available days'**
  String get choose_from_the_available_days;

  /// No description provided for @contact_us_via_whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Contact us via WhatsApp'**
  String get contact_us_via_whatsapp;

  /// No description provided for @here_to_help_contact_us_directly_via_whatsApp.
  ///
  /// In en, this message translates to:
  /// **'We are here to help. Contact us directly via WhatsApp for any questions or concerns you may have.'**
  String get here_to_help_contact_us_directly_via_whatsApp;

  /// No description provided for @need_help.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get need_help;

  /// No description provided for @you_want_to_sign_out.
  ///
  /// In en, this message translates to:
  /// **'You want to Sign Out.'**
  String get you_want_to_sign_out;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @popular_destination.
  ///
  /// In en, this message translates to:
  /// **'Popular Destination'**
  String get popular_destination;

  /// No description provided for @best_deal.
  ///
  /// In en, this message translates to:
  /// **'Most booked'**
  String get best_deal;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @hello_need_help_with.
  ///
  /// In en, this message translates to:
  /// **'Hello, I need help with...'**
  String get hello_need_help_with;

  /// No description provided for @kitchen_and_bathroom_available.
  ///
  /// In en, this message translates to:
  /// **'Kitchen and bathroom available'**
  String get kitchen_and_bathroom_available;

  /// No description provided for @number_of_beds.
  ///
  /// In en, this message translates to:
  /// **'Number of beds'**
  String get number_of_beds;

  /// No description provided for @km_to_city.
  ///
  /// In en, this message translates to:
  /// **'km to city'**
  String get km_to_city;

  /// No description provided for @per_night.
  ///
  /// In en, this message translates to:
  /// **'/per night'**
  String get per_night;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @book_now.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get book_now;

  /// No description provided for @more_details.
  ///
  /// In en, this message translates to:
  /// **'More Details'**
  String get more_details;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'read more'**
  String get read_more;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'less'**
  String get less;

  /// No description provided for @overall_rating.
  ///
  /// In en, this message translates to:
  /// **'Overall rating'**
  String get overall_rating;

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get service;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Prcie'**
  String get price;

  /// No description provided for @room_photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get room_photo;

  /// No description provided for @last_update.
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get last_update;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @my_trips.
  ///
  /// In en, this message translates to:
  /// **'My Trip'**
  String get my_trips;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @price_text.
  ///
  /// In en, this message translates to:
  /// **'price (for 1 night)'**
  String get price_text;

  /// No description provided for @popular_filter.
  ///
  /// In en, this message translates to:
  /// **'Popular filter'**
  String get popular_filter;

  /// No description provided for @distance_from_city.
  ///
  /// In en, this message translates to:
  /// **'Distance from city center'**
  String get distance_from_city;

  /// No description provided for @type_of_accommodation.
  ///
  /// In en, this message translates to:
  /// **'Type of Accommodation'**
  String get type_of_accommodation;

  /// No description provided for @apply_text.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_text;

  /// No description provided for @all_text.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_text;

  /// No description provided for @home_text.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_text;

  /// No description provided for @free_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Free Breakfast'**
  String get free_breakfast;

  /// No description provided for @free_Parking.
  ///
  /// In en, this message translates to:
  /// **'Free Parking'**
  String get free_Parking;

  /// No description provided for @pool_text.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get pool_text;

  /// No description provided for @pet_friendlly.
  ///
  /// In en, this message translates to:
  /// **'Pet Friendlly'**
  String get pet_friendlly;

  /// No description provided for @free_wifi.
  ///
  /// In en, this message translates to:
  /// **'Free Wifi'**
  String get free_wifi;

  /// No description provided for @less_than.
  ///
  /// In en, this message translates to:
  /// **'Less than'**
  String get less_than;

  /// No description provided for @km_text.
  ///
  /// In en, this message translates to:
  /// **'Km'**
  String get km_text;

  /// No description provided for @amanda_text.
  ///
  /// In en, this message translates to:
  /// **'Amanda'**
  String get amanda_text;

  /// No description provided for @view_edit.
  ///
  /// In en, this message translates to:
  /// **'View and Edit profile'**
  String get view_edit;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @username_text.
  ///
  /// In en, this message translates to:
  /// **'UserName'**
  String get username_text;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get date_of_birth;

  /// No description provided for @address_text.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address_text;

  /// No description provided for @mail_text.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get mail_text;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @enter_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password and confirm your password'**
  String get enter_your_new_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @invite_friend.
  ///
  /// In en, this message translates to:
  /// **'Invite Friend'**
  String get invite_friend;

  /// No description provided for @invite_your_friend.
  ///
  /// In en, this message translates to:
  /// **'Invite your Friend'**
  String get invite_your_friend;

  /// No description provided for @invite_friend_desc.
  ///
  /// In en, this message translates to:
  /// **'are you one of those who makes everything at the last moment'**
  String get invite_friend_desc;

  /// No description provided for @share_text.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share_text;

  /// No description provided for @credit_coupons.
  ///
  /// In en, this message translates to:
  /// **'Crdit & Coupons'**
  String get credit_coupons;

  /// No description provided for @help_center.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// No description provided for @how_can_help_you.
  ///
  /// In en, this message translates to:
  /// **'How can we help'**
  String get how_can_help_you;

  /// No description provided for @search_help_artical.
  ///
  /// In en, this message translates to:
  /// **'Search help articales'**
  String get search_help_artical;

  /// No description provided for @paying_for_a_reservation.
  ///
  /// In en, this message translates to:
  /// **'Paying for a reservation'**
  String get paying_for_a_reservation;

  /// No description provided for @trust_and_safety.
  ///
  /// In en, this message translates to:
  /// **'Trust and Safety'**
  String get trust_and_safety;

  /// No description provided for @how_do_i.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel my rooms reservation?'**
  String get how_do_i;

  /// No description provided for @what_methods.
  ///
  /// In en, this message translates to:
  /// **'What methods of payment does Roome accept?'**
  String get what_methods;

  /// No description provided for @i_m_a_guest_what.
  ///
  /// In en, this message translates to:
  /// **'I\'m a guest. What are some safety tips I can follow?'**
  String get i_m_a_guest_what;

  /// No description provided for @when_am_i_charged.
  ///
  /// In en, this message translates to:
  /// **'When am I charged for a reservation?'**
  String get when_am_i_charged;

  /// No description provided for @how_do_i_edit.
  ///
  /// In en, this message translates to:
  /// **'How do I edit or remove a payment method?'**
  String get how_do_i_edit;

  /// No description provided for @you_can_cancel.
  ///
  /// In en, this message translates to:
  /// **'You can cancel a reservation any time before Or during your trip. To cancel a reservation:'**
  String get you_can_cancel;

  /// No description provided for @go_to_trips_and_choose_yotr_trip.
  ///
  /// In en, this message translates to:
  /// **'GO to Trips and choose yotr trip Click Your home reservation Click Modify reservation'**
  String get go_to_trips_and_choose_yotr_trip;

  /// No description provided for @you_be_taken_to.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be taken to a new page where you either change or cancel your reservation. Click the Next button under Cancel reservation to Start the cancellation process.'**
  String get you_be_taken_to;

  /// No description provided for @if_you_cancel_your.
  ///
  /// In en, this message translates to:
  /// **'If you cancel, your refund Will be determined by your host\'r cancellation policy. We\'ll show your refund breakdown before you finalize the cancellation.'**
  String get if_you_cancel_your;

  /// No description provided for @give_feedback.
  ///
  /// In en, this message translates to:
  /// **'Give feedback'**
  String get give_feedback;

  /// No description provided for @related_articles.
  ///
  /// In en, this message translates to:
  /// **'Related articles'**
  String get related_articles;

  /// No description provided for @can_i_change.
  ///
  /// In en, this message translates to:
  /// **'Can I change a reservation as a guest?'**
  String get can_i_change;

  /// No description provided for @how_do_i_cancel.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel a reservation request?'**
  String get how_do_i_cancel;

  /// No description provided for @what_is_the.
  ///
  /// In en, this message translates to:
  /// **'What is the Resolution Center?'**
  String get what_is_the;

  /// No description provided for @payment_text.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment_text;

  /// No description provided for @setting_text.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting_text;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @theme_mode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get theme_mode;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'system'**
  String get system;

  /// No description provided for @fonts.
  ///
  /// In en, this message translates to:
  /// **'Fonts'**
  String get fonts;

  /// No description provided for @selected_fonts.
  ///
  /// In en, this message translates to:
  /// **'Selected fonts'**
  String get selected_fonts;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @selected_color.
  ///
  /// In en, this message translates to:
  /// **'Selected color'**
  String get selected_color;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selected_language.
  ///
  /// In en, this message translates to:
  /// **'Selected language'**
  String get selected_language;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @terms_of_services.
  ///
  /// In en, this message translates to:
  /// **'Terms of Services'**
  String get terms_of_services;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @give_us_feedbacks.
  ///
  /// In en, this message translates to:
  /// **'Give Us Feedbacks'**
  String get give_us_feedbacks;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @room_selected.
  ///
  /// In en, this message translates to:
  /// **'Room selected'**
  String get room_selected;

  /// No description provided for @number_room.
  ///
  /// In en, this message translates to:
  /// **'Number of Room'**
  String get number_room;

  /// No description provided for @people_data.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people_data;

  /// No description provided for @room_data.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room_data;

  /// No description provided for @choose_date.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get choose_date;

  /// No description provided for @apply_date.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_date;

  /// No description provided for @from_text.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from_text;

  /// No description provided for @to_text.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to_text;

  /// No description provided for @sleeps.
  ///
  /// In en, this message translates to:
  /// **'sleeps'**
  String get sleeps;

  /// No description provided for @children.
  ///
  /// In en, this message translates to:
  /// **'children'**
  String get children;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'enter new password'**
  String get enter_new_password;

  /// No description provided for @enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'enter confirm password'**
  String get enter_confirm_password;

  /// No description provided for @password_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get password_cannot_empty;

  /// No description provided for @valid_new_password.
  ///
  /// In en, this message translates to:
  /// **'We cannot allow less than 6 lengths of the password, please enter a valid new password'**
  String get valid_new_password;

  /// No description provided for @valid_password.
  ///
  /// In en, this message translates to:
  /// **'We cannot allow less than 6 lengths of the password, please enter a valid password'**
  String get valid_password;

  /// No description provided for @password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Password does not match, please enter a valid password'**
  String get password_not_match;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'enter your email'**
  String get enter_your_email;

  /// No description provided for @email_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get email_cannot_empty;

  /// No description provided for @enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address, abc@xyz.com'**
  String get enter_valid_email;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'enter password'**
  String get enter_password;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enter_first_name;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enter_last_name;

  /// No description provided for @first_name_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'First Name cannot be empty'**
  String get first_name_cannot_empty;

  /// No description provided for @last_name_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'Last Name cannot be empty'**
  String get last_name_cannot_empty;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
