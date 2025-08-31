
import 'package:flutter/material.dart';

import '../common/common.dart';
import '../core/base/custom_button_with_border.dart';
import '../language/app_localizations.dart';
import '../routes/route_names.dart';
import '../utils/uti.dart';


void showLoginDialog() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // alignment: Alignment.bottomCenter,
      // insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: const LoginOrRegisterDialog(),
    ),
  );
}

class LoginOrRegisterDialog extends StatelessWidget {
    final bool isClose;
  const LoginOrRegisterDialog({super.key,   this.isClose=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
           if(isClose==true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UTI.closWidget(),
              ],
            ),
            // text
            Text(Loc.alized.to_display_your_data ),
            const SizedBox(height: 20),
            // login
            CustomButtonWithBorder(
              txt: Loc.alized.login,
              fillColor: true,
              onTap: () {
                Navigator.of(context).pop();
                // AppNavigation.navigateTo(null, const LoginScreen());
                NavigationServices(navigatorKey.currentContext!).gotoLoginScreen();
              },
            ),
            const SizedBox(height: 20),
            CustomButtonWithBorder(
                txt: Loc.alized.create_account,
                fillColor: false,
                onTap: () {
                  Navigator.of(context).pop();
                  NavigationServices(context).gotoSignScreen();
                }),
            // register
          ],
        ),
      ),
    );
  }
}
