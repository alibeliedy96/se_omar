// File: login_screen.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/constants/localfiles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_text_field_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';


import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../logic/auth_cubit/auth_cubit.dart';
import 'login_controller.dart'; // Import the new controller
// --- نهاية الافتراضات ---

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Create an instance of the controller.
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController();
    // No need for a listener if the UI is driven by BlockBuilder
  }

  @override
  void dispose() {
    // 2. Dispose of the controller.
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
              titleText: Loc.alized.login,
              onBackClick: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                // 3. Wrap the content in a Form widget
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(Localfiles.appIcon)),
                      const SizedBox(height: 20),

                      // 4. Connect TextFields to the controller
                      CommonTextFieldView(
                        controller: _controller.emailController,
                        titleText: Loc.alized.your_mail,
                        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                        hintText: Loc.alized.enter_your_email,
                        keyboardType: TextInputType.emailAddress,
                        validator: _controller.validateEmail, // Use validator from controller
                      ),

                      CommonTextFieldView(
                        titleText: Loc.alized.password,
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        hintText: Loc.alized.enter_password,
                        isObscureText: true,
                        controller: _controller.passwordController,
                        validator: _controller.validatePassword, // Use validator from controller
                      ),

                      _forgotYourPasswordUI(),

                      // 5. The login button is now wrapped in your BlockBuilder
                      BlockBuilderWidget<AuthCubit, AuthApiTypes>(
                        types: const [AuthApiTypes.login],
                        loading: (_) => _loginButton(context, loading: true),
                        body: (_) => _loginButton(context, loading: false),
                        error: (_) => _loginButton(context, loading: false),
                      ),

                      CommonButton(
                        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                        buttonText: Loc.alized.create_account,
                        backgroundColor: AppTheme.backgroundColor,
                        textColor: AppTheme.primaryTextColor,
                        onTap: () => _controller.goToSignUp(context),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
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

  Widget _forgotYourPasswordUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onTap: () => _controller.goToForgotPassword(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Loc.alized.forgot_your_password,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for the login button to keep the build method clean
  Widget _loginButton(BuildContext context, {required bool loading}) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: loading
          ?   Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
          : CommonButton(
        buttonText: Loc.alized.login,
        onTap: () => _controller.login(context),
      ),
    );
  }
}