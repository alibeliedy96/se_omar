// File: change_password_screen.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_text_field_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../logic/profile_cubit/profile_cubit.dart';
import 'change_password_controller.dart'; // Import the new controller


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ChangePasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChangePasswordController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: Loc.alized.change_password,
              onBackClick: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          Loc.alized.enter_your_new_password,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).disabledColor),
                        ),
                      ),

                      // --- Current Password Field ---
                      CommonTextFieldView(
                        controller: _controller.currentPasswordController,
                        titleText: Loc.alized.old_password,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        hintText: Loc.alized.enter_password,
                        isObscureText: true,
                        validator: _controller.validateCurrentPassword,
                      ),

                      // --- New Password Field ---
                      CommonTextFieldView(
                        controller: _controller.newPasswordController,
                        titleText: Loc.alized.new_password,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        hintText: Loc.alized.enter_new_password,
                        isObscureText: true,
                        validator: _controller.validateNewPassword,
                      ),

                      // --- Confirm Password Field ---
                      CommonTextFieldView(
                        controller: _controller.confirmPasswordController,
                        titleText: Loc.alized.confirm_password,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        hintText: Loc.alized.enter_confirm_password,
                        isObscureText: true,
                        validator: _controller.validateConfirmPassword,
                      ),
                      const SizedBox(height: 24),

                      // --- Apply Button with Loading State ---
                      BlockBuilderWidget<ProfileCubit, ProfileApiTypes>(
                        types: const [ProfileApiTypes.changePassword],
                        loading: (_) => _applyButton(context, loading: true),
                        body: (_) => _applyButton(context, loading: false),
                        error: (_) => _applyButton(context, loading: false),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _applyButton(BuildContext context, {required bool loading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: loading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
          : CommonButton(
        buttonText: Loc.alized.apply_text,
        onTap: () => _controller.changePassword(context),
      ),
    );
  }
}