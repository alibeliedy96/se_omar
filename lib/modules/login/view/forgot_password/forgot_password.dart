// File: forgot_password_screen.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_text_field_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';

import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../logic/auth_cubit/auth_cubit.dart';
import 'forgot_password_controller.dart'; // Import the new controller


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final ForgotPasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ForgotPasswordController();
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
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: Loc.alized.forgot_your_password,
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
                          Loc.alized.resend_email_link,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).disabledColor),
                        ),
                      ),
                      CommonTextFieldView(
                        controller: _controller.emailController,
                        titleText: Loc.alized.your_mail,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        hintText: Loc.alized.enter_your_email,
                        keyboardType: TextInputType.emailAddress,
                        validator: _controller.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      // The "Send" button is now wrapped in your BlockBuilder
                      BlockBuilderWidget<AuthCubit, AuthApiTypes>(
                        // Note: The cubit uses AuthApiTypes.login for this action.
                        types: const [AuthApiTypes.forgotPassword],
                        loading: (_) => _sendButton(context, loading: true),
                        body: (_) => _sendButton(context, loading: false),
                        error: (_) => _sendButton(context, loading: false),
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

  // Helper method for the send button to keep the build method clean
  Widget _sendButton(BuildContext context, {required bool loading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: loading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
          : CommonButton(
        buttonText: Loc.alized.send,
        onTap: () => _controller.sendResetLink(context),
      ),
    );
  }
}