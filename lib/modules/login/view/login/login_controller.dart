// File: login_controller.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:mr_omar/utils/validator.dart';
import 'package:mr_omar/language/app_localizations.dart';


import '../../../bottom_tab/bottom_tab_screen.dart';
import '../../domain/request/login_request.dart';
import '../../logic/auth_cubit/auth_cubit.dart';



/// Controller for the LoginScreen.
/// Manages UI state and business logic for the login process.
class LoginController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final AuthCubit _cubit = AuthCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ==========================
  //      Public Methods (UI Actions)
  // ==========================

  /// Handles the login button tap.
  /// Validates the form and calls the login API via the cubit.
  void login(BuildContext context) {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Validate the form
    if (formKey.currentState?.validate() ?? false) {
      // If the form is valid, create the request model
      final loginRequest = LoginRequestModel(
        // Assuming your model takes email and password
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Call the cubit to perform the login
      _cubit.login(loginBody: loginRequest, context: context).then((_) {
        // You can add navigation logic here based on the cubit's state after login
        // For example, if login is successful:
        // if (AuthCubit.get().state is LoginSuccessState) {

        // }
      });
    }
  }

  /// Validates the email field.
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.email_cannot_empty;
    }
    if (!Validator.validateEmail(value.trim())) {
      return Loc.alized.enter_valid_email;
    }
    return null;
  }

  /// Validates the password field.
  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.password_cannot_empty;
    }
    if (value.trim().length < 6) {
      return Loc.alized.valid_password;
    }
    return null;
  }

  /// Navigates to the forgot password screen.
  void goToForgotPassword(BuildContext context) {
    NavigationServices(context).gotoForgotPassword();
  }

  /// Navigates to the sign-up screen.
  void goToSignUp(BuildContext context) {
    NavigationServices(context).gotoSignScreen();
  }

  // ==========================
  //      Lifecycle
  // ==========================
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}