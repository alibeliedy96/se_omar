import 'package:flutter/material.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/login/facebook_twitter_button_view.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:mr_omar/utils/validator.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_text_field_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';

import '../../constants/localfiles.dart';
import '../../constants/themes.dart';
import '../bottom_tab/bottom_tab_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorEmail = '';
  final TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: Loc.alized.login,
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20,),
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset(Localfiles.appIcon)),
                    const SizedBox(height: 20,),
                    CommonTextFieldView(
                      controller: _emailController,
                      errorText: _errorEmail,
                      titleText: Loc.alized.your_mail,
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      hintText: Loc.alized.enter_your_email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      titleText: Loc.alized.password,
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      hintText: Loc.alized.enter_password,
                      isObscureText: true,
                      onChanged: (String txt) {},
                      errorText: _errorPassword,
                      controller: _passwordController,
                    ),
                    _forgotYourPasswordUI(),
                    CommonButton(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      buttonText: Loc.alized.login,
                      onTap: () {
                        if (_allValidation()) {
                          NavigationServices(context).navigateAndFinish(context,const BottomTabScreen());
                        }
                      },
                    ),
                    CommonButton(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      buttonText: Loc.alized.create_account,
                      backgroundColor: AppTheme.backgroundColor,
                      textColor: AppTheme.primaryTextColor,
                      onTap: () {
                        NavigationServices(context).gotoSignScreen();
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onTap: () {
              NavigationServices(context).gotoForgotPassword();
            },
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

  bool _allValidation() {
    bool isValid = true;
    if (_emailController.text.trim().isEmpty) {
      _errorEmail = Loc.alized.email_cannot_empty;
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = Loc.alized.enter_valid_email;
      isValid = false;
    } else {
      _errorEmail = '';
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword = Loc.alized.password_cannot_empty;
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      _errorPassword = Loc.alized.valid_password;
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
