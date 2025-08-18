// File: change_password_controller.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/language/app_localizations.dart';
import '../../domain/request/change_password_request.dart';
import '../../logic/profile_cubit/profile_cubit.dart';


/// Controller for the ChangePasswordScreen.
class ChangePasswordController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final ProfileCubit _cubit = ProfileCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // ==========================
  //      Public Methods
  // ==========================

  /// Validates the form and calls the change password API.
  void changePassword(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (formKey.currentState?.validate() ?? false) {
      final request = ChangePasswordRequest(
        currentPassword: currentPasswordController.text,
        password: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      _cubit.changePassword(context: context, changePasswordRequest: request).then((_) {
        // The cubit handles showing the snackbar and navigation on success.
      });
    }
  }

  // ==========================
  //      Validation Methods
  // ==========================
  String? validateCurrentPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.password_cannot_empty;
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.password_cannot_empty;
    }
    if (value.trim().length < 6) {
      return Loc.alized.valid_new_password;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Loc.alized.password_cannot_empty;
    }
    if (newPasswordController.text.trim() != value.trim()) {
      return Loc.alized.password_not_match;
    }
    return null;
  }

  // ==========================
  //      Lifecycle
  // ==========================
  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}