import 'package:flutter/material.dart';
import 'package:mr_omar/constants/localfiles.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/login/view/register/register_controller.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_text_field_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../logic/auth_cubit/auth_cubit.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignUpController();
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
              titleText: Loc.alized.sign_up,
              onBackClick: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      SizedBox(height: 80, width: 80, child: Image.asset(Localfiles.appIcon)),
                      const SizedBox(height: 20),

                      CommonTextFieldView(
                        controller: _controller.nameController,
                        padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                        titleText: Loc.alized.fullName,
                        hintText: Loc.alized.fullName,
                        keyboardType: TextInputType.name,
                        validator: _controller.validateFirstName,
                      ),

                      CommonTextFieldView(
                        controller: _controller.emailController,
                        titleText: Loc.alized.your_mail,
                        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                        hintText: Loc.alized.enter_your_email,
                        keyboardType: TextInputType.emailAddress,
                        validator: _controller.validateEmail,
                      ),
                      CommonTextFieldView(
                        controller: _controller.phoneController,
                        titleText: Loc.alized.your_phone,
                        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                        hintText: Loc.alized.enter_your_phone,
                        keyboardType: TextInputType.phone,
                        validator: _controller.validatePhone,
                      ),
                      CommonTextFieldView(
                        titleText: Loc.alized.password,
                        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                        hintText: Loc.alized.enter_password,
                        isObscureText: true,
                        controller: _controller.passwordController,
                        validator: _controller.validatePassword,
                      ),

                      CommonTextFieldView(
                        titleText: Loc.alized.password_confirmation,
                        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                        hintText: Loc.alized.enter_password_confirmation,
                        isObscureText: true,
                        controller: _controller.passwordConfirmationController,
                        validator:(p0) {
                          return _controller.validatePasswordConfirmation(p0, _controller.passwordController.text);
                        } ,
                      ),


                      BlockBuilderWidget<AuthCubit, AuthApiTypes>(
                        types: const [AuthApiTypes.register],
                        loading: (_) => _signUpButton(context, loading: true),
                        body: (_) => _signUpButton(context, loading: false),
                        error: (_) => _signUpButton(context, loading: false),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(Loc.alized.terms_agreed, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).disabledColor)),
                      ),
                      _alreadyHaveAccount(context),
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
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

  Widget _signUpButton(BuildContext context, {required bool loading}) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
      child: loading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
          : CommonButton(
        buttonText: Loc.alized.sign_up,
        onTap: () => _controller.signUp(context),
      ),
    );
  }

  Widget _alreadyHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(Loc.alized.already_have_account, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).disabledColor)),
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: () => _controller.goToLogin(context),
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
    );
  }
}