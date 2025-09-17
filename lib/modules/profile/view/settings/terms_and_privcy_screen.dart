import 'package:flutter/material.dart';

import '../../../../widgets/common_appbar_view.dart';
import '../../../../widgets/remove_focuse.dart';

class TermsAndPrivacyScreen extends StatefulWidget {
  final String title,content;
  const TermsAndPrivacyScreen({super.key, required this.title, required this.content});

  @override
  State<TermsAndPrivacyScreen> createState() => _TermsAndPrivacyScreenState();
}

class _TermsAndPrivacyScreenState extends State<TermsAndPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              onBackClick: () => Navigator.pop(context),
              titleText: widget.title,
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.content),
            ))

          ],
        ),
      ),
    );
  }
}
