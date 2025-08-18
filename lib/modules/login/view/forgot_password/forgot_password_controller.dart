// File: forgot_password_controller.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/utils/validator.dart';
import '../../logic/auth_cubit/auth_cubit.dart';


/// Controller for the ForgotPasswordScreen.
/// Manages UI state and business logic.
class ForgotPasswordController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final AuthCubit _cubit = AuthCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  // ==========================
  //      Public Methods
  // ==========================

  /// Validates the form and calls the forgot password API.
  void sendResetLink(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (formKey.currentState?.validate() ?? false) {
      _cubit.forgotPassword(
        email: emailController.text.trim(),
        context: context,
      ).then((_) {
        // The cubit handles showing the snackbar and navigation on success.
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

  // ==========================
  //      Lifecycle
  // ==========================
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}