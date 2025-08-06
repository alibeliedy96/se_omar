import 'package:flutter/material.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/login/facebook_twitter_button_view.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:mr_omar/utils/validator.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_text_field_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';

import '../../constants/localfiles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _errorEmail = '';
  String _errorPhone = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _errorPassword = '';
  final TextEditingController _passwordController = TextEditingController();
  String _errorFName = '';
  final TextEditingController _fnameController = TextEditingController();
  String _errorLName = '';
  final TextEditingController _lnameController = TextEditingController();

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
            _appBar(),
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
                      controller: _fnameController,
                      errorText: _errorFName,
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: Loc.alized.first_name,
                      hintText: Loc.alized.enter_first_name,
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      controller: _lnameController,
                      errorText: _errorLName,
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: Loc.alized.last_name,
                      hintText: Loc.alized.enter_last_name,
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                    ),
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
                      controller: _phoneController,
                      errorText: _errorPhone,
                      titleText: Loc.alized.your_phone,
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      hintText: Loc.alized.enter_your_phone,
                      keyboardType: TextInputType.phone,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      titleText: Loc.alized.password,
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 24),
                      hintText: Loc.alized.enter_password,
                      isObscureText: true,
                      onChanged: (String txt) {},
                      errorText: _errorPassword,
                      controller: _passwordController,
                    ),
                    CommonButton(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                      buttonText: Loc.alized.sign_up,
                      onTap: () {
                        if (_allValidation()) {
                          NavigationServices(context).gotoTabScreen();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        Loc.alized.terms_agreed,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Loc.alized.already_have_account,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                        InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          onTap: () {
                            NavigationServices(context).gotoLoginScreen();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              Loc.alized.login,
                              style: TextStyles(context).regular().copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 24,
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

  Widget _appBar() {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText: Loc.alized.sign_up,
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_fnameController.text.trim().isEmpty) {
      _errorFName = Loc.alized.first_name_cannot_empty;
      isValid = false;
    } else {
      _errorFName = '';
    }

    if (_lnameController.text.trim().isEmpty) {
      _errorLName = Loc.alized.last_name_cannot_empty;
      isValid = false;
    } else {
      _errorLName = '';
    }

    if (_emailController.text.trim().isEmpty) {
      _errorEmail = Loc.alized.email_cannot_empty;
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = Loc.alized.enter_valid_email;
      isValid = false;
    } else {
      _errorEmail = '';
    }
    if (_phoneController.text.trim().isEmpty) {
      _errorPhone = Loc.alized.phone_cannot_empty;
      isValid = false;
    } else if (!Validator.validateMobile(_phoneController.text.trim())) {
      _errorPhone = Loc.alized.enter_valid_phone;
      isValid = false;
    } else {
      _errorPhone = '';
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
