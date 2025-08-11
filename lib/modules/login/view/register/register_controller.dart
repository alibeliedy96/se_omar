// File: sign_up_controller.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:mr_omar/utils/validator.dart';


import '../../domain/request/register_request.dart';
import '../../logic/auth_cubit/auth_cubit.dart';
// --- نهاية الافتراضات ---

/// Controller for the SignUpScreen.
/// Manages UI state and business logic for the registration process.
class SignUpController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final AuthCubit _cubit = AuthCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  // ==========================
  //      Public Methods (UI Actions)
  // ==========================

  /// Handles the sign-up button tap.
  void signUp(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (formKey.currentState?.validate() ?? false) {
      final registerRequest = RegisterRequest(
        // Assuming your request model has these fields
        name:  nameController.text.trim(),

        email: emailController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        password: passwordController.text.trim(),
        passwordConfirmation: passwordConfirmationController.text.trim(),
      );

       _cubit.registerUser(context: context, register: registerRequest);
    }
  }

  /// Navigates to the login screen.
  void goToLogin(BuildContext context) {
    NavigationServices(context).gotoLoginScreen();
  }

  // ==========================
  //      Validation Methods
  // ==========================
  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.first_name_cannot_empty;
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.last_name_cannot_empty;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.email_cannot_empty;
    }
    if (!Validator.validateEmail(value.trim())) {
      return Loc.alized.enter_valid_email;
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.phone_cannot_empty;
    }
    if (!Validator.validateMobile(value.trim())) {
      return Loc.alized.enter_valid_phone;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.password_cannot_empty;
    }
    if (value.trim().length < 8) {
      return Loc.alized.valid_password;
    }
    return null;
  }

  String? validatePasswordConfirmation(String? value, String? originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.password_cannot_empty;
    }
    if (value.trim().length < 8) {
      return Loc.alized.valid_password;
    }
    if (originalPassword != null && value.trim() != originalPassword.trim()) {
      return Loc.alized.passwords_do_not_match;
    }
    return null;
  }


  // ==========================
  //      Lifecycle
  // ==========================
  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}